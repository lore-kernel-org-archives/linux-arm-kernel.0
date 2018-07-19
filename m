From: fabio.berton@ossystems.com.br (Fabio Berton)
Date: Thu, 19 Jul 2018 10:53:02 -0300
Subject: Rockchip RV1108 mainline kernel support
Message-ID: <CAAPZna3aGkUmDeAwM4J6LpeC9m1VA=CUQN_ChiwvTLkaE2zdrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all!

We're adding support to a custom Rockchip RV1108 in mainline kernel.

Currently this custom board runs fine on the Rockchip 3.10 vendor kernel.

The main problems is that kernel 4.17 can't detect eMMC.

I would appreciate any help on how to make the mainline kernel to
detect eMMC on this board

Here the full log:
https://gist.github.com/fbertux/df5b55928dcb703a28b990b72aa2e6fc

and here the log from Rockchip kernel 3.10:
https://gist.github.com/fbertux/9a476ca6903c2029d3db4ea53076be17

This is dts file that we're using:

https://github.com/OSSystems/linux/blob/wip-rockchip/arch/arm/boot/dts/rv1108-minievb-v10.dts

Rockchip RV1108; http://rockchip.wikidot.com/rk1108
Kernel Fork: https://github.com/OSSystems/linux/tree/wip-rockchip
Rockchip kernel 3.10: https://github.com/rockchip-linux/kernel/tree/release-3.10

Thanks!

Fabio Berton
