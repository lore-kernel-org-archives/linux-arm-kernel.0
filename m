From: huziji@marvell.com (Ziji Hu)
Date: Thu, 22 Dec 2016 20:47:07 +0800
Subject: [PATCH v4 06/12] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
In-Reply-To: <20161222111802.GX14217@n2100.armlinux.org.uk>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
 <b8acb86f1e7977648977ed5c6b4eb86323e4b777.1481651244.git-series.gregory.clement@free-electrons.com>
 <20161222111802.GX14217@n2100.armlinux.org.uk>
Message-ID: <c7755b17-d1a8-b1eb-4750-9b57c35768f1@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 2016/12/22 19:18, Russell King - ARM Linux wrote:
> On Tue, Dec 13, 2016 at 06:48:35PM +0100, Gregory CLEMENT wrote:
>> +Optional Properties:
>> +- mmc-card:
>> +  mmc-card child node must be provided when current SDHC is for eMMC.
>> +  Xenon SDHC often can support both SD and eMMC. This child node indicates that
>> +  current SDHC is for eMMC card. Thus Xenon eMMC specific configuration and
>> +  operations can be enabled prior to eMMC init sequence.
>> +  Please refer to Documentation/devicetree/bindings/mmc/mmc-card.txt.
>> +  This child node should not be set if current Xenon SDHC is for SD/SDIO.
> 
> This looks like a typo - shouldn't it be "mmccard" and not "mmc-card"?
> Your examples below use "mmccard" as does the documentation you point
> towards.
>

    Thanks a lot for the review.

    I might mix up it with compatible "mmc-card".
    I will change it to sub-node name in next version soon.

    Thank you.

Best regards,
Hu Ziji
