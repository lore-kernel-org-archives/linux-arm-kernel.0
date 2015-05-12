From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 12 May 2015 22:44:09 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: add system-power-controller to
 act8846
In-Reply-To: <64DE272A-FD25-406C-A51B-6C5B76DA5171@stud.hs-offenburg.de>
References: <64DE272A-FD25-406C-A51B-6C5B76DA5171@stud.hs-offenburg.de>
Message-ID: <2003800.TXlUqeQVab@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 11. Mai 2015, 22:57:21 schrieb Michael Niew?hner:
> Add system-power-controller to act8846 in rk3188-radxarock.dts in addition
> to the act8846 patch fixing the reboot kernel panic
> 
> Signed-off-by: Michael Niewoehner <mniewoeh@stud.hs-offenburg.de>

As the act8846 is the system-power-controller in any case (for example to
powerdown the board) I've applied this patch to my dts branch for 4.2 [0],
after adapting the commit message slightly to make it a bit more generic:
----
ARM: dts: rockchip: add system-power-controller to act8846 on radxarock
The act8846 is the main pmic and system-power-controller on radxarock boards,
so add the necessary property.
----

Hope that is ok with you :-)

Heiko


[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v4.2-armsoc/dts&id=9ab79be0da98e371f1d2f9c01ac25745639718d1
