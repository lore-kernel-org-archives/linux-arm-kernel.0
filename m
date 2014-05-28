From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 May 2014 02:54:46 -0700
Subject: [PATCH 10/12] scsi/NCR5380: remove unused macro definitions
In-Reply-To: <20140318004215.582469999@telegraphics.com.au>
References: <20140318004212.612472697@telegraphics.com.au>
 <20140318004215.582469999@telegraphics.com.au>
Message-ID: <20140528095446.GJ26617@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 11:42:22AM +1100, Finn Thain wrote:
> Remove the unused (and divergent) debugging macro definitions from
> the sun3_NCR5380 and atari_NCR5380 drivers. These drivers have been
> converted to use the common macros in NCR5380.h.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
