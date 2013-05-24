From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 24 May 2013 11:23:23 +0200
Subject: [PATCH v3 6/6] pinctrl: exynos: Handle suspend/resume of GPIO EINT
 registers
In-Reply-To: <CACRpkdbN4Nxg2VSr0bf+h4Y2U=CmX9mijdZz+=tom9V0-i-69g@mail.gmail.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <3059629.yu4Ei1BXhd@amdc1227>
 <CACRpkdbN4Nxg2VSr0bf+h4Y2U=CmX9mijdZz+=tom9V0-i-69g@mail.gmail.com>
Message-ID: <2032031.lFyZLmqevW@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Friday 24 of May 2013 11:12:00 Linus Walleij wrote:
> On Wed, May 22, 2013 at 4:03 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> > Some GPIO EINT control registers needs to be preserved across
> > suspend/resume cycle. This patch extends the driver to take care of
> > this.
> > 
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > 
> > Changes since v2:
> >  - Fixed error path
> > 
> > Changes since v1:
> >  - Added optional debugging messages
> >  - Added proper error path in initialization
> 
> v2 version applied for fixes.

I posted v3 two days ago. It fixes a stupid mistake in error path I made in a 
hurry and also addresses some suggestions from Doug.

> Again confirm you must really have all this. It is not looking
> good with diffstats like this for fixing regressions.

Yes. The whole series is necessary to have correct suspend/resume support of 
DT-enabled Exynos boards.

Best regards,
-- 
Tomasz Figa
Linux Kernel Developer
Samsung R&D Institute Poland
Samsung Electronics
