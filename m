From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 14 May 2013 21:25:13 +0900
Subject: [PATCH v3] ARM: exynos: Select PINCTRL_EXYNOS for exynos4/5 at
 chip level
In-Reply-To: <CACRpkdZ3grCyf3x5dEbT6hAVDkpM3mwibVO5kT0Lv=a09-zBPA@mail.gmail.com>
References: <1368039168-24447-1-git-send-email-dianders@chromium.org>
 <1368123170-22906-1-git-send-email-dianders@chromium.org>
 <CACRpkdZ3grCyf3x5dEbT6hAVDkpM3mwibVO5kT0Lv=a09-zBPA@mail.gmail.com>
Message-ID: <093701ce509e$15ba0350$412e09f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 
> On Thu, May 9, 2013 at 8:12 PM, Doug Anderson <dianders@chromium.org>
> wrote:
> 
> > Previously if you had MACH_EXYNOS5_DT but not MACH_EXYNOS4_DT you'd be
> > missing the pincontrol definitions.  Move PINCTRL selects to the arch
> > level since we should be enabling the code for all exynos variants.
> >
> > Update the PINCTRL descriptions to indicate that PINCTRL_EXYNOS is not
> > for exynos5440.  Also add basic dependencies for the PINCTRL_EXYNOS
> > kernel config.
> >
> > Signed-off-by: Doug Anderson <dianders@chromium.org>
> > ---
> > Changes in v3:
> > - Moved to chip level as per Tomasz.
> > - Update PINCTRL Kconfig for exynos.
> >
> > Changes in v2:
> > - Moved to the arch level as suggested by Olof.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org> for the pinctrl
> part, I guess this will be merged through the Samsung tree?
> 
Linus, thanks for your ack.

Let me take this into samsung tree.

- Kukjin
