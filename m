From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Sep 2012 09:55:40 +0900
Subject: [RFC PATCH 1/2] ARM: kexec: scan for dtb magic in segments
In-Reply-To: <1346938503-18142-2-git-send-email-matthew.leach@arm.com>
References: <1346938503-18142-1-git-send-email-matthew.leach@arm.com>
 <1346938503-18142-2-git-send-email-matthew.leach@arm.com>
Message-ID: <20120907005540.GC23851@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 02:35:02PM +0100, Matthew Leach wrote:
> This patch allows a dtb to be passed to a new kernel using the kexec
> mechinism.
> 
> When loading segments from userspace, scan each segment's first four
> bytes for the dtb magic. If this is found set the kexec_boot_atags
> parameter to the relocate_kernel code to the phyical address of this
> segment.
> 
> Cc: Simon Horman <horms@verge.net.au>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Matthew Leach <matthew.leach@arm.com>
> ---

Reviewed-by: Simon Horman <horms@verge.net.au>
