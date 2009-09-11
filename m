From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 11 Sep 2009 19:56:58 +0200
Subject: [GIT PULL] PXA changes for this merge window
In-Reply-To: <alpine.DEB.2.00.0909120055460.26978@sl400-karmic>
References: <alpine.DEB.2.00.0909120055460.26978@sl400-karmic>
Message-ID: <20090911175658.GP9410@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Sat, Sep 12, 2009 at 12:58:35AM +0800, Eric Miao wrote:
> Daniel Mack (7):
>       [ARM] pxa: add MFP_PULL_FLOAT
>       [ARM] pxa: add clock definition for graphics controller
>       [ARM] pxa: add device definition for graphics controller
>       [ARM] pxa: rename GCU IRQ for consistency
>       [ARM] pxafb: use resource_size() function
>       [ARM] pxa/colibri: add NAND config for Colibri PXA3xx boards
>       [ARM] pxafb: add accelerator ID for PXA3xx GCU

What do you think about the gcu driver itself? Is it a good idea to take
that one, too?

Daniel
