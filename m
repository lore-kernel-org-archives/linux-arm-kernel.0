From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 03 Nov 2016 15:32:13 +0100
Subject: [PATCH] clk: rockchip: fix some clocks' name to be more standard
 style
In-Reply-To: <763cad68-a068-9a4b-e26d-2c459c2d4808@rock-chips.com>
References: <1478070296-23080-1-git-send-email-jay.xu@rock-chips.com>
 <763cad68-a068-9a4b-e26d-2c459c2d4808@rock-chips.com>
Message-ID: <44798035.VNVnDcOLnj@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. November 2016, 16:52:48 schrieb Shawn Lin:
> On 2016/11/2 15:04, Jianqun Xu wrote:
> > Fix aclk_emmcgrf to aclk_emmc_grf, and fix aclk_emmccore to be
> > aclk_emmc_core.
> 
> What is the standard style should be?
> 
> TRM uses aclk_emmccore but not aclk_emmc_core, so should it be more
> standrad to keep it as-is?

I tend to agree with Shawn. While it looks like the missing "_" is some sort 
of mistake, we should strive to follow TRM naming, so grepping so it becomes 
easier to look for informations in these things in the TRM.

Same reason for naming our regulators and pinctrl after the names used in 
device schematics, if available.


Heiko
