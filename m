From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 May 2014 02:50:41 -0700
Subject: [PATCH 06/12] scsi/NCR5380: fix dprintk macro usage and definition
In-Reply-To: <20140318004214.402473367@telegraphics.com.au>
References: <20140318004212.612472697@telegraphics.com.au>
 <20140318004214.402473367@telegraphics.com.au>
Message-ID: <20140528095041.GF26617@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 11:42:18AM +1100, Finn Thain wrote:
> There are three implementations of the core NCR5380 driver and three sets
> of debugging macro definitions. And all three implementations use the
> NCR5380.h header as well.
> 
> Two of the definitions of the dprintk macro accept a variable argument list
> whereas the third does not. Standardize on the variable argument list.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
