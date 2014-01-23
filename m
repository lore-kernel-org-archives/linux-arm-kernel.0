From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Jan 2014 09:36:54 +0100
Subject: [PATCH] pinctrl: Rename Broadcom Capri pinctrl driver
In-Reply-To: <CACRpkdZ+3MC8XpfD-vumvq3yQACzFn89DQjWQeXbdBK+9JmfLQ@mail.gmail.com>
References: <1390343886-25852-1-git-send-email-syin@broadcom.com>
 <CACRpkdZ+3MC8XpfD-vumvq3yQACzFn89DQjWQeXbdBK+9JmfLQ@mail.gmail.com>
Message-ID: <CACRpkdbEtQCBeMr-vM1prD8hOcPOdMfH_-pGt5aesPYKZ2n4Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 9:17 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jan 21, 2014 at 11:38 PM, Sherman Yin <syin@broadcom.com> wrote:
>
>> To be consistent with other Broadcom drivers, the Broadcom Capri pinctrl
>> driver and its related CONFIG option are renamed to bcm281xx.
>>
>> Devicetree compatible string and binding documentation use
>> "brcm,bcm11351-pinctrl" to match the machine binding here:
>> Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
>>
>> This driver supports pinctrl on BCM11130, BCM11140, BCM11351, BCM28145
>> and BCM28155 SoCs.
>>
>> Signed-off-by: Sherman Yin <syin@broadcom.com>
>> Reviewed-by: Matt Porter <mporter@linaro.org>
>
> Patch applied for fixes.

No wait. I took the patch out.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

This driver is already causing a messy conflict situation in ARM SoC.
I don't want to escalate their problem.

Either you merge this through ARM SoC or split off the arch/arm/*
changes into a separate patch for ARM SoC.

Yours,
Linus Walleij
