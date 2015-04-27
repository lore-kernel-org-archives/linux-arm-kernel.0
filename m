From: vianney.leclement@essensium.com (Vianney le =?iso-8859-1?q?Cl=E9ment?=)
Date: Mon, 27 Apr 2015 11:42:38 +0200
Subject: [PATCH] ARM: dts: imx6: Add Embest MarS Board
In-Reply-To: <20150427083917.GD9231@dragon>
References: <1427875809-10444-1-git-send-email-vianney.leclement@essensium.com>
 <20150427083917.GD9231@dragon>
Message-ID: <1430127758.1475.2@mail.essensium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Thanks for taking time reviewing this.  I will send a follow-up patch.

On Mon, Apr 27, 2015 at 10:39 , Shawn Guo <shawn.guo@linaro.org> wrote:
> If eMMC doesn't work yet, you should just not add it.

Thanks to Lucas and Catalin it does work now :).  Will update it in v2.


> For new dts file, we suggest to use GPL/X11 dual-license for non-Linux
> users. Find example below.
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/imx6q-hummingboard.dts

No problem for dual-licensing on my part, but this dts is heavily based 
on imx6q-riotboard.dts (as mentioned in the header), which is only 
licensed under the GPL.


>>  +		pinctrl_usbotg: usbotggrp {
>>  +			fsl,pins = <
>>  +				MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x17059
>>  +				MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x000b0	/* 
>> MX6QDL_PAD_EIM_D22__USB_OTG_PWR */
> 
> What does the comment mean?

It is a leftover from imx6q-riotboard.dts.  I will change it.

Regards,
Vianney

Vianney le Cl?ment de Saint-Marcq
Embedded Software Developper ? +32 485 84 55 05
Essensium, Mind division ? www.mind.be
GPG: 727B CFE9 355F 1B02 0820 EE1C 9042 3E07 A804 0316
