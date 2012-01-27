From: scottwood@freescale.com (Scott Wood)
Date: Fri, 27 Jan 2012 11:02:51 -0600
Subject: [RFC PATCH 6/7] ARM: mtd: nand: davinci: add OF support for
 davinci nand controller
In-Reply-To: <4F2246C0.6020905@denx.de>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-7-git-send-email-hs@denx.de> <4F1DF465.60206@freescale.com>
 <4F1E5C82.60108@denx.de> <4F1F0A3E.40805@freescale.com>
 <4F1FAAAE.2060007@denx.de> <4F21B8AC.40002@freescale.com>
 <4F2246C0.6020905@denx.de>
Message-ID: <4F22D8BB.6090801@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2012 12:40 AM, Heiko Schocher wrote:
> Hello Scott,
> 
> Scott Wood wrote:
>> On 01/25/2012 01:09 AM, Heiko Schocher wrote:
>>> ecc_mode:
>>> NAND_ECC_NONE
>>> NAND_ECC_SOFT
>>> NAND_ECC_HW
>>> NAND_ECC_HW_SYNDROME
> 
> "ti,davinci-nand-ecc-mode" = "none", "soft", "hw" or "hw_syndrome"

OK.

>>> bbt_options:
>>> NAND_BBT_USE_FLASH
> 
> "ti,davinci-nand-bbt-options" = "use_flash"

Just make it a boolean ti,davinci-nand-use-bbt

>>> ecc_bits:
>>> 1
>>> 4
> 
> "ti,davinci-nand-ecc-bits" = "1" or "4"

<1> or <4>

>>> options:
>>> NAND_BUSWIDTH_16
> 
> "ti,davinci-nand-options" = "buswidth-16"

ti,davinci-nand-buswidth = <16>;

-Scott
