From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 May 2014 02:49:41 -0700
Subject: [PATCH 04/12] scsi/NCR5380: use NCR5380_dprint() instead of
 NCR5380_print()
In-Reply-To: <20140318004213.812935479@telegraphics.com.au>
References: <20140318004212.612472697@telegraphics.com.au>
 <20140318004213.812935479@telegraphics.com.au>
Message-ID: <20140528094941.GD26617@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 11:42:16AM +1100, Finn Thain wrote:
> Only the NCR5380_dprint() macro should invoke the NCR5380_print() function.
> That's why NCR5380.c only defines the function #if NDEBUG. Use the standard
> macro.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
