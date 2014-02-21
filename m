From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Feb 2014 11:31:06 +0800
Subject: [PATCH] ARM: dts: mxs: Fix the RTC compatible prop on M28EVK
In-Reply-To: <201402210414.00167.marex@denx.de>
References: <1390519416-6760-1-git-send-email-marex@denx.de>
 <201402201331.37932.marex@denx.de>
 <20140221020914.GP3010@S2101-09.ap.freescale.net>
 <201402210414.00167.marex@denx.de>
Message-ID: <20140221033102.GS3010@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 04:14:00AM +0100, Marek Vasut wrote:
> On Friday, February 21, 2014 at 03:09:16 AM, Shawn Guo wrote:
> > On Thu, Feb 20, 2014 at 01:31:37PM +0100, Marek Vasut wrote:
> > > On Friday, January 24, 2014 at 12:23:36 AM, Marek Vasut wrote:
> > > > The compatible property should be m41t62, not mt41t62, so fix this.
> > > > 
> > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > 
> > > Bump ?
> > 
> > Applied.  Sorry for the delay.
> 
> Sure, no problem. Thanks. Shall I submit this for -stable too ?

Oh, at this time which already passes -rc3, I didn't categorize it as a
critical fix (build error, kernel dumps, system hang) that we should
send right away for 3.14 and -stable.  If you do, you can try to resend
it to arm-soc folks with my ACK.

Shawn
