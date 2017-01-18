From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 18 Jan 2017 16:13:46 +0200
Subject: [PATCH v5 3/4] dmaengine: pl330: Store pointer to slave device
In-Reply-To: <539bd321-66f5-9d06-923e-88dcb12787b8@samsung.com>
References: <1484657338-26338-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124922eucas1p1d4037d80229e55007169cf85c19e5eec@eucas1p1.samsung.com>
 <1484657338-26338-4-git-send-email-m.szyprowski@samsung.com>
 <20170117172445.3itztktiay22as26@kozik-lap>
 <539bd321-66f5-9d06-923e-88dcb12787b8@samsung.com>
Message-ID: <20170118141346.wfwp7ybtqmwsiee7@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 08:07:22AM +0100, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2017-01-17 18:29, Krzysztof Kozlowski wrote:
> > On Tue, Jan 17, 2017 at 01:48:57PM +0100, Marek Szyprowski wrote:
> > > Store the pointer to slave device, which requested our channel. It will be
> > > later used to implement runtime PM of PL330 DMA controller. Although
> > > DMA channels might be requested many times, each DMA peripheral channel is
> > > physically dedicated only for specific hardware, so there should be only
> > > one slave device for each channel.
> > > 
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Any particular reason for removing my Reviewed-by? Any changes here?
> 
> No changes here. I'm sorry, the tag got lost during rebase.

Okay:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
