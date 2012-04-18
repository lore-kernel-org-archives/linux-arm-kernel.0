From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 18 Apr 2012 23:42:43 +0200
Subject: [PATCH 3/3] ARM: mx28evk: Add SPI NOR flash support
In-Reply-To: <20120403192653.GA2201@pengutronix.de>
References: <1333480807-10480-1-git-send-email-festevam@gmail.com>
 <1333480807-10480-3-git-send-email-festevam@gmail.com>
 <20120403192653.GA2201@pengutronix.de>
Message-ID: <201204182342.43269.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> Hi Fabio,
> 
> On Tue, Apr 03, 2012 at 04:20:07PM -0300, Fabio Estevam wrote:
> > Add SPI NOR flash support.
> > 
> > By default, the mx28evk board does not come with a SPI NOR flash
> > populated.
> > 
> > Soldered a sst25vf016b and tested it using mtd-utils.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> > I will submit the spi-mxs driver in a day or so.
> 
> \o/ Looking forward to that one!

Hey, did you get anywhere with this?

> However, I think this patch should include registering the spi-device as
> well?
> 
> Regards,
> 
>    Wolfram

Best regards,
Marek Vasut
