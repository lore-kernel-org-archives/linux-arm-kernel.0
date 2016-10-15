From: ayaka@soulik.info (ayaka)
Date: Sun, 16 Oct 2016 02:03:11 +0800
Subject: rockchip: drm: analogix_dp-rockchip would stock the kernel
Message-ID: <1a7ebbe4-a9d8-610d-7cd5-41f5fe8355a5@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello:
    I meet a problem with eDP in rk3288 with the linux next 20161006, it 
is just like the early stage of 4.4
kernel.  I have added a eDP panel entry in the firefly reload board, 
once the kernel loaded analogix_dp-rockchip.ko, after printed the 
following two lines, the kernel stop working.
rockchip-drm display-subsystem: bound ff940000.vop (ops 
vop_component_ops [rockchipdrm])
rockchip-drm display-subsystem: bound ff930000.vop (ops 
vop_component_ops [rockchipdrm])
In the early June of the 4.4 kernel, I meet the same problem with rk3288 
evb board with different error message, I have to disable the display 
system that time.
   In the today test, I meet the same problem with rk3399 evb board in 4.4.
   I have no idea what caused that, and it is a little hard to debug as 
kernel still would never kill that task.
                                                             Randy Li
