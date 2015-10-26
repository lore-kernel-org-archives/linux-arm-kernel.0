From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Oct 2015 14:10:17 +0100
Subject: [PATCH 00/10] ARM MTD AFS v2 partition support
In-Reply-To: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdbH3yP3jbeeGxrAJXoJeXJQtnPfZpQ1dtx7DpP9_uaZhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 3:08 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> Years ago, the ARM reference platforms moved away from the footer
> format parsed by the current AFS code in MTD. As far as I can
> tell this begun with the RealView reference designs (mach-realview)
> and the new format has been used in RealView, Versatile Express
> and recently the Juno Development platform (64bit).
>
> The code has not been working for newer designs for a long time.
> Proper parsing of the flash image partitions is very helpful when
> you want to replace firmware when running full Linux and none of
> the boot monitors or boot loaders.
>
> After this, AFS parsing will work on all ARM reference designs,
> or well, all I could test. I tested the Integrator/AP, RealView
> PB11MPCore and Juno Development Platform.
>
> The first 9 patches basically refactors the current code to
> make the old partition format more encapsulated, while the last
> patch adds the new v2 format.

If there are no comments on this series, then can it be
applied for v4.4?

Yours,
Linus Walleij
