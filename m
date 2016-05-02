From: kamlakant.patel@broadcom.com (Kamlakant Patel)
Date: Mon, 2 May 2016 18:42:41 +0530
Subject: [PATCH] arm64: vulcan: enable GPIOLIB in Kconfig
In-Reply-To: <CACRpkdY07afPyo35Fh25FXPCXED8UymbwS3AbqFnGauSmRHMwA@mail.gmail.com>
References: <1461819767-17539-1-git-send-email-kamlakant.patel@broadcom.com>
 <CACRpkdY07afPyo35Fh25FXPCXED8UymbwS3AbqFnGauSmRHMwA@mail.gmail.com>
Message-ID: <CAB=aS0NbfH-YRJKtZ1N_OukpdXXdYeQTnuSBSP1HnCWoYSV2cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sat, Apr 30, 2016 at 2:02 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Apr 28, 2016 at 7:02 AM,  <kamlakant.patel@broadcom.com> wrote:
>
>> From: Kamlakant Patel <kamlakant.patel@broadcom.com>
>>
>> Add select GPIOLIB in Kconfig for Broadcom Vulcan ARM64 GPIO driver.
>>
>> Signed-off-by: Kamlakant Patel <kamlakant.patel@broadcom.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> But don't you also want to select the actual driver?
>
Vulcan GPIO is compatible with gpio/gpio-xlp.c driver. We have already
updated gpio/Kconfig for this.
I will send the device tree changes in next patch.


Thanks,
Kamlakant Patel
