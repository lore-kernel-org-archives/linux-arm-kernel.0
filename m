From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Nov 2017 06:52:41 -0800
Subject: [PATCH] ARM: dts: am4372: Correct the interrupts_properties of
 McASP
In-Reply-To: <20171101090331.15435-1-peter.ujfalusi@ti.com>
References: <20171101090331.15435-1-peter.ujfalusi@ti.com>
Message-ID: <20171128145241.GV28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [171101 02:04]:
> Fixes the following wanring:
> arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /ocp at 44000000/mcasp at 48038000
> arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /ocp at 44000000/mcasp at 4803C000

Applying into omap-for-v4.15/fixes thanks.

Tony
