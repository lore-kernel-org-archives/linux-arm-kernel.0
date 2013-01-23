From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Jan 2013 10:21:42 +0800
Subject: [PATCH v5 00/14] DMA Engine support for AM33XX
In-Reply-To: <50FEB6B2.5020303@ti.com>
References: <1358281974-8411-1-git-send-email-mporter@ti.com>
 <50FEB6B2.5020303@ti.com>
Message-ID: <20130123022133.GA5727@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 09:26:34PM +0530, Sekhar Nori wrote:
> On 1/16/2013 2:02 AM, Matt Porter wrote:

> > This series adds DMA Engine support for AM33xx, which uses
> > an EDMA DMAC. The EDMA DMAC has been previously supported by only
> > a private API implementation (much like the situation with OMAP
> > DMA) found on the DaVinci family of SoCs.

> Will you take this series through the OMAP tree? Only 1/14 touches
> mach-davinci and I am mostly okay with it except some changes I just
> requested Matt to make in another thread.

Is this series somewhere near actually getting merged then? It seemed
like there was lots of stuff going on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130123/7c6c5165/attachment.sig>
