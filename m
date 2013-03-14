From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Mar 2013 14:04:45 +0800
Subject: [PATCH 08/10] ASoC: dmaengine_pcm: Add open function for DT DMA
 request
In-Reply-To: <20130313104945.GI25610@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-9-git-send-email-mpa@pengutronix.de>
 <20130312190206.GY19942@opensource.wolfsonmicro.com>
 <20130313021712.GD27461@S2101-09.ap.freescale.net>
 <20130313104945.GI25610@opensource.wolfsonmicro.com>
Message-ID: <20130314060442.GB27654@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 10:49:45AM +0000, Mark Brown wrote:
> On Wed, Mar 13, 2013 at 10:18:29AM +0800, Shawn Guo wrote:
> 
> > I did not see any objection from you on that patch, so I'm waiting for
> > you to publish a branch for it, so that my mxs-dma generic binding
> > series can move forward.
> 
> I commented on the removal of the const from the name parameter (and

I just double checked my mailbox and can only see the conversation
between you and rmk, nothing particularly on the removal of the const
from the name parameter.  Or I'm still missing something?

Shawn
