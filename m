From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 1 Oct 2012 13:42:47 +0200
Subject: [PATCH] i2c-nomadik: Fixup clock handling
In-Reply-To: <CACRpkdZZ-gNBi7EDwhXHawmzPD9dE8wo9voX-MJ7CYQ058k-Jw@mail.gmail.com>
References: <1348154447-3815-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdZZ-gNBi7EDwhXHawmzPD9dE8wo9voX-MJ7CYQ058k-Jw@mail.gmail.com>
Message-ID: <CAPDyKFpyB7SBY=Ht7Mz8KsC_eugNVTMF1C251BYPZMS2pFsDYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Juts a kind reminder on this. Do you see any problem merging this?

Kind regards
Ulf Hansson

On 20 September 2012 21:17, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Sep 20, 2012 at 5:20 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>
>> From: Philippe Begnic <philippe.begnic@stericsson.com>
>>
>> Make sure to clk_prepare as well as clk_enable.
>
> Looks correct. xfer() is slowpatch so we might as well call
> prepare/unprepare functions there.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
