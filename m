From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 15 Dec 2009 10:31:42 +0200
Subject: [PATCH 3/4] fec: add support for Freescale i.MX25 PDK (3DS)
In-Reply-To: <20091214103348.GV15126@pengutronix.de>
References: <cover.1260785451.git.baruch@tkos.co.il>
	<fb518184b206ec2727deda111cc5364134ace69a.1260785451.git.baruch@tkos.co.il>
	<20091214103348.GV15126@pengutronix.de>
Message-ID: <20091215083142.GB18290@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Dec 14, 2009 at 11:33:48AM +0100, Sascha Hauer wrote:
> On Mon, Dec 14, 2009 at 12:19:41PM +0200, Baruch Siach wrote:
> > +	if (!machine_is_mx25_3ds())
> > +		return;
> 
> We should add a flag in platform data for this. Unfortunately the fec
> driver has no platform data at all at the moment, so this requires some
> more work.

Here is an updated patch which adds platform data to fec. I've also addressed 
the comment of Greg. I'll post a patch updating the i.MX25 PDK platform code 
shortly.

baruch
