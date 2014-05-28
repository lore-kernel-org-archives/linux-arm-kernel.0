From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 May 2014 02:48:49 -0700
Subject: [PATCH 01/12] scsi/NCR5380: remove unused BOARD_NORMAL and
 BOARD_NCR53C400
In-Reply-To: <20140318004212.932470722@telegraphics.com.au>
References: <20140318004212.612472697@telegraphics.com.au>
 <20140318004212.932470722@telegraphics.com.au>
Message-ID: <20140528094849.GA26617@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 11:42:13AM +1100, Finn Thain wrote:
> BOARD_NORMAL is completely unused and BOARD_NCR53C400 is used only by
> g_NCR5380 internally. Remove the unused definitions.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
