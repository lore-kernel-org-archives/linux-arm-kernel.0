From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Oct 2018 17:32:51 +0100
Subject: [PATCH 3/5] arm64: mm: make use of new memblocks_present() helper
In-Reply-To: <20181005161642.2462-4-logang@deltatee.com>
References: <20181005161642.2462-1-logang@deltatee.com>
 <20181005161642.2462-4-logang@deltatee.com>
Message-ID: <20181005163248.naky3huexiiwycra@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 10:16:40AM -0600, Logan Gunthorpe wrote:
> Cleanup the arm64_memory_present() function seeing it's very
> similar to other arches.
> 
> memblocks_present() is a direct replacement of arm64_memory_present()
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  arch/arm64/mm/init.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
