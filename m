From: fthain@telegraphics.com.au (Finn Thain)
Date: Wed, 28 May 2014 22:09:33 +1000 (EST)
Subject: [PATCH 05/12] scsi/NCR5380: fix build failures when debugging
 is enabled
In-Reply-To: <20140528095015.GE26617@infradead.org>
References: <20140318004212.612472697@telegraphics.com.au>
 <20140318004214.102469994@telegraphics.com.au>
 <20140528095015.GE26617@infradead.org>
Message-ID: <alpine.LNX.2.00.1405282207580.31798@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 28 May 2014, Christoph Hellwig wrote:

> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks for reviewing. There was a later submission (version 2) with 
changes made to three of these patches,

[PATCH v2 05/12] scsi/NCR5380: fix build failures when debugging is enabled
[PATCH v2 06/12] scsi/NCR5380: fix dprintk macro usage and definition
[PATCH v2 09/12] scsi/NCR5380: fix and standardize NDEBUG macros

And several patches in the v2 submission had some acked-by tags added.

The v2 series is the one to merge (but I think James intends to do that).

-- 
