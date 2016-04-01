From: will.deacon@arm.com (Will Deacon)
Date: Fri, 1 Apr 2016 09:50:55 +0100
Subject: [PATCH] Xen on ARM and ARM64: update MAINTAINERS info
In-Reply-To: <alpine.DEB.2.02.1603241121090.18380@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1603241121090.18380@kaball.uk.xensource.com>
Message-ID: <20160401085054.GA21136@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 11:01:16AM +0100, Stefano Stabellini wrote:
> Not my full time job anymore, but still maintaining it.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32bafda..049aa1d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12193,16 +12193,16 @@ F:	include/xen/
>  F:	include/uapi/xen/
>  
>  XEN HYPERVISOR ARM
> -M:	Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> +M:	Stefano Stabellini <sstabellini@kernel.org>
>  L:	xen-devel at lists.xenproject.org (moderated for non-subscribers)
> -S:	Supported
> +S:	Maintained
>  F:	arch/arm/xen/
>  F:	arch/arm/include/asm/xen/
>  
>  XEN HYPERVISOR ARM64
> -M:	Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> +M:	Stefano Stabellini <sstabellini@kernel.org>
>  L:	xen-devel at lists.xenproject.org (moderated for non-subscribers)
> -S:	Supported
> +S:	Maintained
>  F:	arch/arm64/xen/
>  F:	arch/arm64/include/asm/xen/

Acked-by: Will Deacon <will.deacon@arm.com>

Will
