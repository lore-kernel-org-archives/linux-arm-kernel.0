From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 21 Mar 2013 14:10:08 +0100
Subject: [PATCH 1/2] dmaengine: add const for name parameter
In-Reply-To: <20130321094753.GN10326@intel.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <1363318601-31505-2-git-send-email-shawn.guo@linaro.org>
 <20130315085346.GA22650@pengutronix.de>
 <20130321094753.GN10326@intel.com>
Message-ID: <20130321131008.GA7274@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 21, 2013 at 03:17:53PM +0530, Vinod Koul wrote:
> On Fri, Mar 15, 2013 at 09:53:46AM +0100, Markus Pargmann wrote:
> > Hi,
> > 
> > I already sent a nearly identical patch:
> > https://patchwork.kernel.org/patch/2179321/
> I applied that one a while ago so Markus can you check my tree and see if
> anything is remaining, looks most of cases are covered

I looked in your slave-dma tree but can't find the patch there. The
names are not defined as constant in that tree.

Regards

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
