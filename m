From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Apr 2017 10:50:54 +0100
Subject: [GIT PULL] mfd: exynos-lpass: Pinctrl dependency
In-Reply-To: <CAJKOXPeVOMBZxXeh7=oXbgnxSrUtHa86eAtP2BppY=G4Uygarg@mail.gmail.com>
References: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
 <20170328154217.5405-1-krzk@kernel.org>
 <20170403101824.rpvkqzyigonyi77p@dell>
 <CAJKOXPeVOMBZxXeh7=oXbgnxSrUtHa86eAtP2BppY=G4Uygarg@mail.gmail.com>
Message-ID: <20170404095054.7m6nf6bxweskabuu@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 04 Apr 2017, Krzysztof Kozlowski wrote:

> On Mon, Apr 3, 2017 at 12:18 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 28 Mar 2017, Krzysztof Kozlowski wrote:
> >
> >>
> >> Hi Lee,
> >>
> >>
> >> This is dependency for mfd/exynos-lpass driver changes from Marek Szyprowski.
> >> That's a material for v4.12 and I will be pushing this later to Linus Walleij.
> >
> > This does not work, and *may* still break.
> >
> > The only way to guarantee the order of the patches is to have them
> > *all* as part of the pull-request.  Not just some of them.
> 
> What do you mean exactly? If these two patches come through my tree
> first, then everything will work fine because they do not break any
> other stuff.
> 
> If you pull it and apply the rest on top, then it should also work
> without problems because your history will contain everything needed
> in proper order.
> 
> In both cases bisectability is preserved. Did I missed something?

Okay, so you're suggesting that I rebase MFD *on-top* of your PR.  That
does work for me because I insist on being able to re-work my tree at
any time.  However, be aware that some Maintainers do not work this
way, thus *normally* you will have to send PR containing all of the
dependant patches.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
