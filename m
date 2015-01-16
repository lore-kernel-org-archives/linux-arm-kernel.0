From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Jan 2015 16:19:13 +0100
Subject: [PATCH v2 RESEND 1/3] gpio: Add APM X-Gene standby GPIO
 controller driver
In-Reply-To: <CAL4ahLfGNc1sL-hr7bZi_pcxjz7CNHjPRSPnJf_TUCGsbweaDA@mail.gmail.com>
References: <1418793050-26927-1-git-send-email-yvo@apm.com>
 <1418793050-26927-2-git-send-email-yvo@apm.com>
 <CACRpkdZe7Huiruu-iSNU4MWaiLo_qL=QAab1crummuuVOEJ0zQ@mail.gmail.com>
 <CAL4ahLfGNc1sL-hr7bZi_pcxjz7CNHjPRSPnJf_TUCGsbweaDA@mail.gmail.com>
Message-ID: <CACRpkdYjsQFgbZMSE6v1vQRP5OK-4vvDzOrk07NHxywXZ-4sGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 9:27 AM, Y Vo <yvo@apm.com> wrote:
> On Tue, Jan 13, 2015 at 4:40 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> This looks very much like a memory-mapped standard GPIO controller,
>> use drivers/gpio/gpio-generic.c with some IRQ add-on, compare
>> to any other driver selecting GPIO_GENERIC for guidance:
>> drivers/gpio/gpio-74xx-mmio.c, gpio-dwapb.c etc.
>
> You mean I must rewrite to use GPIO_GENERIC follow gpio-74xx-mmio.c,
> gpio-dwapb.c ?

Yes.

Yours,
Linus Walleij
