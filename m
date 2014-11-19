From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 19 Nov 2014 17:40:50 +0100
Subject: [PATCH] ARM: dts: dove: add DT LCD controllers
In-Reply-To: <E1Xr3Ur-0005Qx-Fx@rmk-PC.arm.linux.org.uk>
References: <E1Xr3Ur-0005Qx-Fx@rmk-PC.arm.linux.org.uk>
Message-ID: <20141119174050.122a0cc0@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Nov 2014 11:32:29 +0000
Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> +			lcd1: lcd-controller at 810000 {
> +				compatible = "marvell,dove-lcd";
> +				reg = <0x810000 0x1000>;
> +				interrupts = <46>;
> +				status = "disabled";
> +			};

The I/O range of the LCDs is only 0x1c8. Why do you set it 0x1000?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
