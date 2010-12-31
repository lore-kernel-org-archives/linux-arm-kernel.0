From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 31 Dec 2010 17:23:36 +0100
Subject: [PATCH v3 1/8] ARM: mx5: use config to define boot related
	addresses
In-Reply-To: <20101231020156.GG28246@freescale.com>
References: <1293684968-7338-1-git-send-email-richard.zhao@freescale.com>
	<20101230093127.GO14221@pengutronix.de>
	<20101230110026.GA30513@shlinux1.ap.freescale.net>
	<20101230110506.GY14221@pengutronix.de>
	<20101231020156.GG28246@freescale.com>
Message-ID: <20101231162336.GI14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Fri, Dec 31, 2010 at 10:01:57AM +0800, Shawn Guo wrote:
> On Thu, Dec 30, 2010 at 12:05:06PM +0100, Uwe Kleine-K?nig wrote:
> > On Thu, Dec 30, 2010 at 07:00:26PM +0800, Richard Zhao wrote:
> > > On Thu, Dec 30, 2010 at 10:31:27AM +0100, Uwe Kleine-K?nig wrote:
> > > > looks good
> > > > 
> > > > Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > Thanks.
> > > For such patch acked, do I need to re-send it out when I send out v4 version
> > > of the patch series?
> > As I'm not the imx-maintainer, I'd say yes, send it out (with my ack
> > added) in v4.
> > 
> Richard was trying to understand the correct approach for sending
> patch series.
> 
> I used to only send the updated patches in the new patch series
> since the last series version, while Richard prefer to send all
> the patches in the very single version, even most of them are not
> changed since the last version.
> 
> I think the sending delta way could save bandwidth and ease reviewing
> a little bit, while sending all may be easy for people to pick up
> the patches. So what is the preference for you guys?
It's more usual to always send all patches of the series and that's what
I prefer.  IIRC Russell pointed that out for one of your series, too.
Optimally document for unchanged patches that they are unchanged.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
