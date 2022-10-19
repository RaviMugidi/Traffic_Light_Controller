`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:53:36 10/19/2022 
// Design Name: 
// Module Name:    traffic_control 
// Project Name:   traffic light controller based on the corresponding state sensor signal.
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module traffic_control(n_lights,s_lights,e_lights,w_lights,clk,rst_a,x1,x2,x3,x4);

   output reg [2:0] n_lights,s_lights,e_lights,w_lights; 
   input      clk;
   input      rst_a;
   input      x1,x2,x3,x4;
 
   reg [2:0] state;
 
   parameter [2:0] north=3'b000;
   parameter [2:0] north_y=3'b001;
   parameter [2:0] south=3'b010;
   parameter [2:0] south_y=3'b011;
   parameter [2:0] east=3'b100;
   parameter [2:0] east_y=3'b101;
   parameter [2:0] west=3'b110;
   parameter [2:0] west_y=3'b111;

   reg [3:0] count;
 

   always @(posedge clk, posedge rst_a,posedge x1,posedge x2,posedge x3,posedge x4)
     begin
        if (rst_a)
            begin
                state<=north;
                count <=4'b0000;
            end
        else
            begin
                case (state)
                north :
                    begin
                        if (count==4'b1111 || x1==1'b1) 
                            begin
                            count<=4'b0000;
                            state<=north_y;
                            
                            end
                        else
                            begin
                                 count<=count+4'b0001;
                                 state<=north;
                            end
                            
                    end

                north_y :
                    begin
                        if (count==4'b0011)
                            begin
                            count<=4'b0000;
                            state<=south;
                            end
                        else
                            begin
                            count<=count+4'b0001;
                            state<=north_y;
                        end
                    end

               south :
                    begin
                        if (count==4'b1111 || x2 == 1'b1)
                            begin
                            count<=4'b0000;
                            state<=south_y;
                            end
                        else
                            begin
                            count<=count+4'b0001;
                            state<=south;
                        end
                    end

            south_y :
                begin
                    if (count==4'b0011)
                        begin
                        count<=4'b0000;
                        state<=east;
                        end
                    else
                        begin
                        count<=count+4'b0001;
                        state<=south_y;
                        end
                    end

            east :
                begin
                    if (count==4'b1111 || x3 == 1'b1)
                        begin
                        count<=4'b0000;
                        state<=east_y;
                        end
                    else
                        begin
                        count<=count+4'b0001;
                        state<=east;
                        end
                    end

            east_y :
                begin
                    if (count==4'b0011)
                        begin
                        count<=4'b0000;
                        state<=west;
                        end
                    else
                        begin
                        count<=count+4'b0001;
                        state<=east_y;
                        end
                    end

            west :
                begin
                    if (count==4'b1111  || x4 == 1'b1)
                        begin
                        state<=west_y;
                        count<=4'b0000;
                        end
                    else
                        begin
                        count<=count+4'b0001;
                        state<=west;
                        end
                    end

            west_y :
                begin
                    if (count==4'b0011)
                        begin
                        state<=north;
                        count<=4'b0000;
                        end
                    else
                        begin
                        count<=count+4'b0001;
                        state<=west_y;
                        end
                    end
            endcase // case (state)
        end // always @ (state)
    end 


always @(state)
     begin
         case (state)
            north :
                begin
                    n_lights <= 3'b001;
                    s_lights <= 3'b100;
                    e_lights <= 3'b100;
                    w_lights <= 3'b100;
                end // case: north

            north_y :
                begin
                    n_lights <= 3'b010;
                    s_lights <= 3'b100;
                    e_lights <= 3'b100;
                    w_lights <= 3'b100;
                end // case: north_y

            south :
                begin
                    n_lights <= 3'b100;
                    s_lights <= 3'b001;
                    e_lights <= 3'b100;
                    w_lights <= 3'b100;
                end // case: south

            south_y :
                begin
                    n_lights <= 3'b100;
                    s_lights <= 3'b010;
                    e_lights <= 3'b100;
                    w_lights <= 3'b100;
                end // case: south_y

            west :
                begin
                    n_lights <= 3'b100;
                    s_lights <= 3'b100;
                    e_lights <= 3'b100;
                    w_lights <= 3'b001;
                end // case: west

            west_y :
                begin
                    n_lights <= 3'b100;
                    s_lights <= 3'b100;
                    e_lights <= 3'b100;
                    w_lights <= 3'b010;
                end // case: west_y

            east :
                begin
                    n_lights <= 3'b100;
                    s_lights <= 3'b100;
                    e_lights <= 3'b001;
                    w_lights <= 3'b100;
                end // case: east

            east_y :
                begin
                    n_lights <= 3'b100;
                    s_lights <= 3'b100;
                    e_lights <= 3'b010;
                    w_lights <= 3'b100;
                end // case: east_y
            endcase // case (state)
     end // always @ (state)
endmodule
