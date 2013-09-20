From: jeffrey.t.kirsher@intel.com (Jeff Kirsher)
Date: Fri, 20 Sep 2013 12:45:55 -0700
Subject: [PATCH 12/51] DMA-API: net: intel/e1000: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
In-Reply-To: <E1VMluG-0007gV-6y@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMluG-0007gV-6y@rmk-PC.arm.linux.org.uk>
Message-ID: <1379706355.1972.8.camel@jtkirshe-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-19 at 22:37 +0100, Russell King wrote:
> Replace the following sequence:
> 
>         dma_set_mask(dev, mask);
>         dma_set_coherent_mask(dev, mask);
> 
> with a call to the new helper dma_set_mask_and_coherent().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130920/d9b04c0f/attachment.sig>
