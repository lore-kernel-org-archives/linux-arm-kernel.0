From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Apr 2013 21:16:33 +0800
Subject: [PATCH] ARM: imx1: mm: add call to mxc_device_init
In-Reply-To: <20130325140940.GH1906@pengutronix.de>
References: <1363448999-3936-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <20130325140940.GH1906@pengutronix.de>
Message-ID: <20130402131630.GE27148@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha,

On Mon, Mar 25, 2013 at 03:09:40PM +0100, Sascha Hauer wrote:
> On Sat, Mar 16, 2013 at 04:49:59PM +0100, Gwenhael Goavec-Merou wrote:
> > mxc_device_init() is mandatory for mxc_aips and mxc_ahb bus registration, needed 
> > as parents, at least, for gpio and dma.
> > 
> > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> 
> Applied, thanks

I did not see this patch in those you ask me to handle.  Has it been
handled or just missed?

Shawn
