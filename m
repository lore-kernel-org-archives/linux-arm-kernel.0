From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 24 Nov 2012 00:15:39 -0800
Subject: [PATCH 0/2] Input: nomadik-ske-keypad - clk fixups
In-Reply-To: <CAPDyKFq+MBo2338SiAF-mdDHpgTDJ0p6k2BaicJpSutGqtaubA@mail.gmail.com>
References: <1351779602-13818-1-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFq+MBo2338SiAF-mdDHpgTDJ0p6k2BaicJpSutGqtaubA@mail.gmail.com>
Message-ID: <20121124081539.GC24711@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Fri, Nov 23, 2012 at 04:54:09PM +0100, Ulf Hansson wrote:
> On 1 November 2012 15:20, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Due to the convert to the common clk driver these changes for clks are needed.
> >
> > Ulf Hansson (2):
> >   Input: nomadik-ske-keypad - fixup use of clk
> >   Input: nomadik-ske-keypad - start using the apb_pclk
> >
> >  drivers/input/keyboard/nomadik-ske-keypad.c |   34 +++++++++++++++++++++++----
> >  1 file changed, 29 insertions(+), 5 deletions(-)
> >
> > --
> > 1.7.10
> >
> 
> Just a kind reminder here. Do we see any issues with merging this?

Both are in my 'next' branch, sorry for not notifying you earlier.

-- 
Dmitry
