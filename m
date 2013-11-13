From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Nov 2013 18:16:12 +0100
Subject: [PATCH v11] dmaengine: Add MOXA ART DMA engine driver
In-Reply-To: <20131113135912.GA8834@intel.com>
References: <1381155034-11254-1-git-send-email-jonas.jensen@gmail.com>
 <1381221756-4925-1-git-send-email-jonas.jensen@gmail.com>
 <20131113135912.GA8834@intel.com>
Message-ID: <201311131816.13268.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 November 2013, Vinod Koul wrote:
> On Tue, Oct 08, 2013 at 10:42:36AM +0200, Jonas Jensen wrote:
> > The MOXA ART SoC has a DMA controller capable of offloading expensive
> > memory operations, such as large copies. This patch adds support for
> > the controller including four channels. Two of these are used to
> > handle MMC copy on the UC-7112-LX hardware. The remaining two can be
> > used in a future audio driver or client application.
> I see this is pending and I first need the AKC on DT parts of the patch before
> we can apply this.
> 
> Also pls cc dmaengine at vger.kernel.org on this patch

The DT binding looks good to me

Acked-by: Arnd Bergmann <arnd@arndb.de>

However, in the future, such binding should also be sent to the
devicetree at vger.kernel.org list for review, in a separate patch,
as clarified during the kernel summit.

	Arnd
