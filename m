From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 May 2014 02:50:15 -0700
Subject: [PATCH 05/12] scsi/NCR5380: fix build failures when debugging is
 enabled
In-Reply-To: <20140318004214.102469994@telegraphics.com.au>
References: <20140318004212.612472697@telegraphics.com.au>
 <20140318004214.102469994@telegraphics.com.au>
Message-ID: <20140528095015.GE26617@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 11:42:17AM +1100, Finn Thain wrote:
> The change from cmd->target to cmd->device->id was apparently the purpose of
> commit a7f251228390e87d86c5e3846f99a455517fdd8e in
> kernel/git/tglx/history.git but some instances have been missed.
> 
> Also fix the "NDEBUG_LAST_WRITE_SENT" and "NDEBUG_ALL" typo's.
> 
> Also fix some format strings (%ul becomes %lu) that caused compiler warnings.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
