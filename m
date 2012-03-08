From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 8 Mar 2012 20:37:41 +0800
Subject: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine driver working
 with fsl_ssi
In-Reply-To: <20120308120207.GJ3638@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <4F57ECC7.1040100@freescale.com>
 <20120308120207.GJ3638@opensource.wolfsonmicro.com>
Message-ID: <20120308123739.GC2499@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 12:02:07PM +0000, Mark Brown wrote:
> On Wed, Mar 07, 2012 at 05:18:31PM -0600, Timur Tabi wrote:
> 
> > I've tested this patchset, and after adding the changes that I pointed out
> > in my previous email, audio still works on the P1022DS and MPC8610HPCD.
> 
> > Therefore:
> 
> > Acked-by: Timur Tabi <timur@freescale.com>
> 
> Excellent, it's great to see the SSI drivers merged!  Shawn, could you
> please resend the unapplied patches with all the relevant acks collected
> and tweaks that people requested just to make sure I've got everything.
> 
Sure.  I got interrupted from the work during the past 2 days, but I'm
resuming it now.

> I know Sascha wanted some slightly larger changes to the new card driver
> so if you want to hold off on that until you've done the updates that's
> fine but it'd be good to get all the other stuff merging the drivers
> together for 3.4 if we can.

That's my goal too.

-- 
Regards,
Shawn
