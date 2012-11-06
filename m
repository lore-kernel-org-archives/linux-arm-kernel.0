From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Nov 2012 09:09:39 +0100
Subject: [PATCH V2 4/5] pinctrl: SPEAr: Add gpio ranges support
In-Reply-To: <3b2f9fa0864f1f736e24ee0dbc081cd9a79b7468.1351330569.git.viresh.kumar@linaro.org>
References: <cover.1351330569.git.viresh.kumar@linaro.org>
 <3b2f9fa0864f1f736e24ee0dbc081cd9a79b7468.1351330569.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdbRDi-TcDvVbAywMeWocfyYUrXS3a=e_GS5onXBj1Cdng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 11:51 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Most of SPEAr SoCs, which support pinctrl, can configure & use pads as gpio.
> This patch gpio enable support for SPEAr pinctrl drivers.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>
> It has few differences since the time it was last posted. I kept your Acked-by
> as the changes aren't that big (I believe). :)

This does not apply to my devel branch, so I guess it is dependent
on some of the stuff I just merged to fixes. I will send the
fixes up to Torvalds, then merge fixes to the devel branch
so we can proceed with patches 4 and 5, OK?

Yours,
Linus Walleij
