From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 17 Jul 2015 00:32:44 +0200
Subject: [PATCH and GIT PULL 0/5] ARM: initial Rockchip stuff for 4.3
Message-ID: <2820374.NgluYWXZkW@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin, Arnd,

The 3 patches add support for the rk3368 ARM64 soc from Rockchip.
Patch 3/3 needs a dependency, namely

  git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-rk3368

which Stephen Boyd declared stable.

The patches for rk3368 have been on the lists for 3 weeks now.

The two pull requests then add stuff for the 32bit Rockchip socs
explained in the signed tags in them.


So if nothing stands out, please apply and pull.


Thanks
Heiko
