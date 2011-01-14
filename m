From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 14 Jan 2011 16:01:50 +0800
Subject: [PATCH 1/2] arm: mx50_rdp: add fec support
In-Reply-To: <20110114075024.GB24920@pengutronix.de>
References: <1294988137-24654-1-git-send-email-richard.zhao@freescale.com>
	<20110114075024.GB24920@pengutronix.de>
Message-ID: <20110114080148.GA12186@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 08:50:24AM +0100, Uwe Kleine-K?nig wrote:
> Hello Richard,
> 
> On Fri, Jan 14, 2011 at 02:55:36PM +0800, Richard Zhao wrote:
> > +static const struct fec_platform_data fec_data = {
> This can be __initconst.
Right, Thanks.
> 
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
