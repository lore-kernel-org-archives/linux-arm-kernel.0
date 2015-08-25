From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Aug 2015 07:15:43 +0200
Subject: [PATCH v3] dmaengine: hdmac: Add memset capabilities
In-Reply-To: <20150824142425.GL13546@localhost>
References: <1440408075-26438-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150824142425.GL13546@localhost>
Message-ID: <20150825051543.GZ2413@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 07:54:25PM +0530, Vinod Koul wrote:
> On Mon, Aug 24, 2015 at 11:21:15AM +0200, Maxime Ripard wrote:
> > Just like for the XDMAC, the SoCs that embed the HDMAC don't have any kind
> > of GPU, and need to accelerate a few framebuffer-related operations through
> > their DMA controller.
> > 
> > However, unlike the XDMAC, the HDMAC doesn't have the memset capability
> > built-in. That can be easily emulated though, by doing a transfer with a
> > fixed address on the variable that holds the value we want to set.
> 
> Applied, thanks

Thanks for merging it so quickly, and sorry for the silent conflict.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150825/d7122093/attachment.sig>
