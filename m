From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 24 Sep 2010 09:25:44 +0200
Subject: [PATCH 1/3] dmaengine: add possibility for cyclic transfers
In-Reply-To: <AANLkTi=B1ZkoYZ3hjuzz8Uj=W-04cE+iedaMwurUMRPy@mail.gmail.com>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-2-git-send-email-s.hauer@pengutronix.de>
	<20100920130119.GA23406@pengutronix.de>
	<AANLkTi=B1ZkoYZ3hjuzz8Uj=W-04cE+iedaMwurUMRPy@mail.gmail.com>
Message-ID: <20100924072544.GN23406@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 12:42:20PM -0700, Dan Williams wrote:
> On Mon, Sep 20, 2010 at 6:01 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Hi Dan,
> >
> > Any comment to this patch?
> 
> Looks good to me especially given the unique implications for
> callbacks.  Although, I'd like to put a description of the
> prep_dma_cyclic semantics in the source code.  Can you respin this
> with a description added to the kernel-doc for struct dma_device?

Sure, will do.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
