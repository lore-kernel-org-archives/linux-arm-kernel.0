From: panand@redhat.com (Pratyush Anand)
Date: Thu, 9 Jun 2016 22:36:24 +0530
Subject: [PATCH] Remove "max" parameter comment
In-Reply-To: <E1bB2em-0004ll-0u@e0050434b2927.dyn.armlinux.org.uk>
References: <20160608012257.GA28638@verge.net.au>
 <E1bB2em-0004ll-0u@e0050434b2927.dyn.armlinux.org.uk>
Message-ID: <20160609170624.GA28087@dhcppc6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2016:05:18:08 PM, Russell King wrote:
> Remove the "max" parameter in the documentation for mem_regions_add()
> 
> Signed-off-by: Russell King <rmk@armlinux.org.uk>
Reviewed-by: Pratyush Anand <panand@redhat.com> 
> ---
>  kexec/mem_regions.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
> index b01a5c89..e61c0747 100644
> --- a/kexec/mem_regions.c
> +++ b/kexec/mem_regions.c
> @@ -31,7 +31,6 @@ void mem_regions_sort(struct memory_ranges *ranges)
>  /**
>   * mem_regions_add() - add a memory region to a set of ranges
>   * @ranges: ranges to add the memory region to
> - * @max: maximum number of entries in memory region
>   * @base: base address of memory region
>   * @length: length of memory region in bytes
>   * @type: type of memory region
> -- 
> 1.9.1
