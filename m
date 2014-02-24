From: marex@denx.de (Marek Vasut)
Date: Mon, 24 Feb 2014 19:02:44 +0100
Subject: [PATCH] ARM: dts: mxs: Fix the RTC compatible prop on M28EVK
In-Reply-To: <20140221033102.GS3010@S2101-09.ap.freescale.net>
References: <1390519416-6760-1-git-send-email-marex@denx.de>
 <201402210414.00167.marex@denx.de>
 <20140221033102.GS3010@S2101-09.ap.freescale.net>
Message-ID: <201402241902.45058.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 21, 2014 at 04:31:06 AM, Shawn Guo wrote:
> On Fri, Feb 21, 2014 at 04:14:00AM +0100, Marek Vasut wrote:
> > On Friday, February 21, 2014 at 03:09:16 AM, Shawn Guo wrote:
> > > On Thu, Feb 20, 2014 at 01:31:37PM +0100, Marek Vasut wrote:
> > > > On Friday, January 24, 2014 at 12:23:36 AM, Marek Vasut wrote:
> > > > > The compatible property should be m41t62, not mt41t62, so fix this.
> > > > > 
> > > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > > 
> > > > Bump ?
> > > 
> > > Applied.  Sorry for the delay.
> > 
> > Sure, no problem. Thanks. Shall I submit this for -stable too ?
> 
> Oh, at this time which already passes -rc3, I didn't categorize it as a
> critical fix (build error, kernel dumps, system hang) that we should
> send right away for 3.14 and -stable.  If you do, you can try to resend
> it to arm-soc folks with my ACK.

So this will go for 3.15 ? I will submit it for stable once it hits mainline, 
it's not critical.

Thanks!

Best regards,
Marek Vasut
