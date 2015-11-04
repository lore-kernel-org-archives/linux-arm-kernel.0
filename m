From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 4 Nov 2015 22:11:20 +0530
Subject: [PATCH] dmaengine: edma: Add dummy driver skeleton for edma3-tptc
In-Reply-To: <87egg54td4.fsf@saruman.tx.rr.com>
References: <1446470500-27504-1-git-send-email-peter.ujfalusi@ti.com>
 <87egg54td4.fsf@saruman.tx.rr.com>
Message-ID: <20151104164120.GO12910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 10:33:27AM -0600, Felipe Balbi wrote:
> Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
> 
> > The eDMA3 TPTC does not need any software configuration, but it is a
> > separate IP block in the SoC. In order the omap hwmod core to be able to
> > handle the TPTC resources correctly in regards of PM we need to have a
> > driver loaded for it.
> > This patch will add a dummy driver skeleton without probe or remove
> > callbacks provided.
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Reported-by: Olof Johansson <olof@lixom.net>
> 
> This fixes the problem I also reported on linux-omap [1]
> 
> Tested-by: Felipe Balbi <balbi@ti.com>
> 
> [1] http://marc.info/?l=linux-omap&m=144665429032014&w=2

Great, I was about to point you to this series, I will push this in -next
now

Thanks
-- 
~Vinod
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/f2f7609b/attachment-0001.sig>
