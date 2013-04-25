From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Apr 2013 14:13:23 +0100
Subject: [PATCH 09/32] ARM: ux500: Remove unused 'data_width' attributes
 from SDI DMA configs
In-Reply-To: <CACRpkdaeuK0p2SynenQjght9fCzTTJpt+S7hGC6d6ahPHAA7Hw@mail.gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdbf03ajQaYujGfimHE+hDVjNLycE3J9Q-W-tzN2EX0fkQ@mail.gmail.com>
 <20130425091428.GD4623@gmail.com>
 <CACRpkdaeuK0p2SynenQjght9fCzTTJpt+S7hGC6d6ahPHAA7Hw@mail.gmail.com>
Message-ID: <20130425131323.GL4623@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Apr 2013, Linus Walleij wrote:

> On Thu, Apr 25, 2013 at 11:14 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 25 Apr 2013, Linus Walleij wrote:
> >
> >> On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >>
> >> > DMA configuration data is now allocated in the MMCI driver, so these
> >> > are just ignored.
> >> >
> >> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>
> >> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >>
> >> I tried just applying this (since it's pretty stand-alone) but seems to
> >> be dependent on things not yet in Torvalds tree so lets keep it in this
> >> series then...
> >
> > Ideally I'd like to keep them all in the same branch, as it may lead
> > to confusion/conflicts later down the line (I'm still coding a lot of
> > this stuff).
> >
> > Naturally, I'll go with whatever you think is best, but this is my
> > preference.
> 
> This works find for now, I just want the DT changes kept separately
> because I'm in hell with these right now and don't want to end up
> there again next merge cycle.

Sure. Just let me know what you plan to manually apply and I'll do my
utmost to keep things sane in the patch-set.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
