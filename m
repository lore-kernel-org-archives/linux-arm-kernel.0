From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 May 2014 02:55:15 -0700
Subject: [PATCH 11/12] scsi/NCR5380: reduce depth of sun3_scsi nested
 includes
In-Reply-To: <20140318004215.872456456@telegraphics.com.au>
References: <20140318004212.612472697@telegraphics.com.au>
 <20140318004215.872456456@telegraphics.com.au>
Message-ID: <20140528095515.GK26617@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 11:42:23AM +1100, Finn Thain wrote:
> Move the #include "NCR5380.h" out of the sun3_scsi.h header file and into
> the driver .c files, like all the other NCR5380 drivers in the tree.
> 
> This improves uniformity and reduces the depth of nested includes. The
> sequence of #include's, #define's and #if's no longer does my head in.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
