From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Jun 2015 12:06:34 +0200
Subject: [PATCHv2 4/5] dmaengine: mv_xor: remove
 mv_xor_chan->current_type field
In-Reply-To: <1434557086-9520-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434557086-9520-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1434557086-9520-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150619100633.GZ11732@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 06:04:45PM +0200, Thomas Petazzoni wrote:
> Since commit 3e4f52e2da9f6 ("dma: mv_xor: Simplify the DMA_MEMCPY
> operation"), this field is no longer used, so get rid of it.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150619/c1651081/attachment-0001.sig>
