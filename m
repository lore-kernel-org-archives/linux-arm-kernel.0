From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 11 Jun 2012 18:00:34 +0200
Subject: [PATCHv10 00/11] I2C fixes
In-Reply-To: <CAM=Q2ctZmOFdroUw5qywwGU_4ResB9RKqag4-+qh3nHeKHWzKQ@mail.gmail.com>
References: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
 <87obp4x8gs.fsf@ti.com>
 <CAM=Q2ctZmOFdroUw5qywwGU_4ResB9RKqag4-+qh3nHeKHWzKQ@mail.gmail.com>
Message-ID: <20120611160034.GA3887@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 11:10:47AM +0530, Shubhrajyoti Datta wrote:
> On Fri, Jun 1, 2012 at 4:29 AM, Kevin Hilman <khilman@ti.com> wrote:
> > Shubhrajyoti D <shubhrajyoti@ti.com> writes:
> >
> >> The patch series does the following
> >>
> >> - Warn fixes if CONFIG_PM_RUNTIME is not selected.
> >> - In case of i2c remove register access was done without any
> >> ?get_sync fix the same.
> >> - Folds a patch from Tasslehoff to prevent any merge conflicts.
> >> - Prevents the XDUF flag to be set if the underflow condition is not met.
> >> - As per discussion in [1] .Adds a patch to rename the 1p153 errata and
> >> ?use the unique id instead as the section number in the recent errata
> >> ?docs has changed.
> >>
> >> v9:
> >> Fix the comments from Wolfram Sang
> >>
> >> v10:
> >> Add a patch from Neil to the series.
> >> Fix kevin comments
> >> update the patches with comments.
> >
> > Shubhrajyoti, thanks for the updates.
> >
> > Wolfgang, with these updates and testing a bit better described, I'm OK
> > with you merging it. ?Merging it now will give it plenty of time to
> > bake in linux-next and get more test exposure.
> 
> Agree,
> These are only fixes can it be considered for rc3?

"Baking in linux-next" and "considering rc3" don't match; baking needs
time, rc3 is soon. I've put the patches now into my -next branch for
more exposure. I am still uncertain if they should be in 3.5 already;
there seem to be worhty fixes in there, but they do depend on stuff
which don't really qualify as bugfixes...

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120611/3175d149/attachment.sig>
