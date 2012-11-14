From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Wed, 14 Nov 2012 16:44:26 +0100
Subject: [PATCH v2 1/2] ARM: mx27_3ds: Add VPU support
In-Reply-To: <20121114143400.GM10369@pengutronix.de>
References: <1352899174-28022-1-git-send-email-fabio.estevam@freescale.com>
 <20121114143400.GM10369@pengutronix.de>
Message-ID: <20121114164426.7a730296@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Le Wed, 14 Nov 2012 15:34:00 +0100,
Sascha Hauer <s.hauer@pengutronix.de> a ?crit :
> On Wed, Nov 14, 2012 at 11:19:33AM -0200, Fabio Estevam wrote:
> > mx27 has a VPU (Video Processing Unit) block that allows doing H264/MPEG4
> > decoding and encoding in hardware.
> > 
> > Add support for it.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> > +	imx27_add_coda();
> 
> Why in the board? It's always present so I would register it in the SoC.
> 
MCIMX27L* dosn't have the VPU. No idea how will behave the probe in
that case.

Eruc
