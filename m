From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Sep 2016 14:22:46 +0200
Subject: [PATCH 1/2] pinctrl: meson-gxbb: add the pins for the
 SDIO/sd_emmc_a controller
In-Reply-To: <CAFBinCDm5quZyyC2t_1SQqT+p=eJQ0H_LoNZM6wfUZugvCi_7g@mail.gmail.com>
References: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
 <20160828164725.19429-2-martin.blumenstingl@googlemail.com>
 <CACRpkdbPVeUA+BSPgQ1XmFJw_J6-V_2BM9h3kO2yq-vUfySsGQ@mail.gmail.com>
 <CAFBinCDm5quZyyC2t_1SQqT+p=eJQ0H_LoNZM6wfUZugvCi_7g@mail.gmail.com>
Message-ID: <CACRpkdbEMCz4SJAKrb2G44_2=jjS+1KamALgjaS41wGGHobM=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2016 at 8:55 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> On Wed, Sep 7, 2016 at 4:24 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sun, Aug 28, 2016 at 6:47 PM, Martin Blumenstingl
>> <martin.blumenstingl@googlemail.com> wrote:
>>
>>> sd_emmc_a is used a controller for the SDIO modules. This adds the pin
>>> configuration for the SDIO controller.
>>>
>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> No reply from maintainers, but you obviously know what you're doing so
>> patch applied.
> I forgot to reply to this one as well (sorry about that):
> I received a NACK off-list for both patches because the SDIO IRQ pin is missing.
>
> Nothing is broken with this patch applied, just one pin is missing.
> Depending on how you'd like to proceed you can:
> - either drop the patch from your tree and wait for v2
> - leave it in your tree and I'll send a patch on top of this one to
> add the missing pin

The latter at this point. Patch the patch.

Thanks!

Linus Walleij
