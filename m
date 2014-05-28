From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 May 2014 02:55:44 -0700
Subject: [PATCH 12/12] scsi/NCR5380: merge sun3_scsi_vme.c into sun3_scsi.c
In-Reply-To: <20140318004216.172443207@telegraphics.com.au>
References: <20140318004212.612472697@telegraphics.com.au>
 <20140318004216.172443207@telegraphics.com.au>
Message-ID: <20140528095544.GL26617@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 11:42:24AM +1100, Finn Thain wrote:
> The sun3 drivers suffer from a whole bunch of duplicated code. Fix this
> by following the g_NCR5380_mmio example. (Notionally, sun3_scsi relates to
> sun3_scsi_vme in the same way that g_NCR5380 relates to g_NCR5380_mmio.)
> 
> Dead code is also removed: we now have working debug macros so
> SUN3_SCSI_DEBUG is undesirable. Dead code within #ifdef OLD_DMA is also
> dropped, consistent with sun3_scsi_vme.c.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
