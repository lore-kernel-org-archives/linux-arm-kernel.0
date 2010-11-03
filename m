From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Nov 2010 20:40:18 +0100
Subject: [patch 1/1] imx: fix iomux v3
In-Reply-To: <321894.13477.qm@web51008.mail.re2.yahoo.com>
References: <20101103145508.186441704@rtp-net.org>
	<321894.13477.qm@web51008.mail.re2.yahoo.com>
Message-ID: <20101103194018.GC11176@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 03, 2010 at 08:25:29AM -0700, Fabio Estevam wrote:
> Arnaud,
> 
> --- On Wed, 11/3/10, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
> 
> > From: Arnaud Patard <arnaud.patard@rtp-net.org>
> > Subject: [patch 1/1] imx: fix iomux v3
> > To: s.hauer at pengutronix.de
> > Cc: linux-arm-kernel at lists.infradead.org, LW at KARO-electronics.de
> > Date: Wednesday, November 3, 2010, 12:54 PM
> > Commit "ARM: i.MX IOMUX-V3 replace
> > struct pad_desc with bitmapped cookie"
> > (b705cb4d42e95a4a43a8945571c8613e71526c3d) introduced a
> > typo which was
> > preventing my efikamx to boot. This patch is fixing that.
> 
> Thanks. When I tried 2.6.37-rc1 today I was not able to boot Linux on Babbage. Your patch fixed the problem.
Hmmm, b705cb4d42e95a4a43a8945571c8613e71526c3d is only in Sascha's
imx-for-2.6.38 branch and Arnaud's patch doesn't apply to Linus tree.

I wonder if that invalidates your tested-by somehow.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
