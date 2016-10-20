From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 20 Oct 2016 21:24:34 +0800
Subject: [linux-sunxi] Re: [PATCH 0/3] pinctrl: sunxi: Support generic
 pinconf functions
In-Reply-To: <CACRpkdZHTQqnsuHcm3+iYQJc2picLu95W2OKeMiXFq+XNzDV3g@mail.gmail.com>
References: <20161004015112.20833-1-wens@csie.org>
 <CACRpkdZHTQqnsuHcm3+iYQJc2picLu95W2OKeMiXFq+XNzDV3g@mail.gmail.com>
Message-ID: <CAGb2v64c8+=sDYrr4-=OxqAs65Vv437dyJP8NiPJZPXcLYHZzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 9:13 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Oct 4, 2016 at 3:51 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>
>> This series fixes up generic pinconf support for the sunxi pinctrl driver
>> library. The driver was doing some bits wrong, like a) storing the pinconf
>> config value in its struct, and not actually reading the hardware to get
>> the current config, and b) not using the right arguments for the bias
>> parameters.
>
> Looks OK to me, Maxime are you OK with me applying this, or
> are we waiting for a new iteration of this patch set?
>
> I have started to apply Maxime's generic binding rework, will it
> clash with these?

They will, as my patches also touch the pinconf .get/.set functions.

ChenYu

>
> Yours,
> Linus Walleij
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
