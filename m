From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jan 2014 21:06:42 +0000
Subject: [PATCH 0/2] DT updates for Hummingboard and new Cubox-i
In-Reply-To: <CAOesGMjBCbMZrpbKjBBUeFhWEkLHS5rERtajRDk0ew_5FYvQEA@mail.gmail.com>
References: <20140116182211.GX15937@n2100.arm.linux.org.uk>
 <20140119031816.GD16158@S2101-09.ap.freescale.net>
 <20140119185246.GB28056@quad.lixom.net>
 <20140120004434.GV15937@n2100.arm.linux.org.uk>
 <CAOesGMiych-jeo_eKGgL1qxsYQ=rkb4UQwgGBsG-7+GMbLJWhg@mail.gmail.com>
 <20140120095532.GW15937@n2100.arm.linux.org.uk>
 <CAOesGMjBCbMZrpbKjBBUeFhWEkLHS5rERtajRDk0ew_5FYvQEA@mail.gmail.com>
Message-ID: <20140120210642.GH15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 12:47:07PM -0800, Olof Johansson wrote:
> On Mon, Jan 20, 2014 at 1:55 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sun, Jan 19, 2014 at 07:34:22PM -0800, Olof Johansson wrote:
> >> I'm guessing this is going to mess up Shawn's cleanup patches, but
> >> time has ran out for 3.14 for those so they will need to be respun
> >> anyway, most likely.
> >>
> >> We can apply them to arm-soc's dt branch. I think it's better if we
> >> merge them since dts files tend to be one of the conflict-ridden areas
> >> (even if this particular instance isn't). Send the series our way if
> >> you want, or send a branch pull request, your choice.
> >
> > There's no conflict, and they build fine according to my autobuilder
> > which includes arm-soc for-next.
> 
> Great, I didn't see any patches sent from you though. Should I
> cherry-pick them from -next instead?

If there's no conflicts, and if there other imx DT changes aren't going
to be submitted, then why is there any need to cherry-pick them into
arm-soc?

Are you suggesting that DT changes happen spontaneously all the time?
If that's true, why couldn't the new board support be put in during
-rc kernels?

What you're saying doesn't really make _that_ much sense to me at the
moment.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
