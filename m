From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 May 2014 08:53:36 -0700
Subject: [PATCH] scsi/NCR5380: dprintk macro
In-Reply-To: <alpine.LNX.2.00.1405290020570.3539@nippy.intranet>
References: <alpine.LNX.2.00.1405290020570.3539@nippy.intranet>
Message-ID: <20140528155336.GB14981@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 12:43:43AM +1000, Finn Thain wrote:
> 
> This is the delta between the two submissions:
> [PATCH 00/12] scsi/NCR5380: fix debugging macros and #include structure
> and
> [PATCH v2 00/12] scsi/NCR5380: fix debugging macros and #include structure
> 
> The macro definition changes were discussed on the mailing list during 
> review. The idea is to get the compiler to check the parameters of 
> disabled printk() calls so that the debugging code doesn't rot again.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks a lot Finn!

> I know the whitespace is wrong throughout these drivers but when I put 
> this patch series together it seemed best to defer the whitespace cleanup. 
>(I still intend to do that cleanup.)

Yes, I ignored the whitespace warnings in the debug macro cleanups.  I
fixed them up for the "newly" added code in the sun3 driver merge.
