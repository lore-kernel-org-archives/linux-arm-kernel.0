From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Fri, 14 Sep 2012 09:09:13 -0400
Subject: [PATCH v4 24/24] MAINTAINERS: add myself as Xen ARM maintainer
In-Reply-To: <1347621207-11294-24-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
 <1347621207-11294-24-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20120914130913.GL25249@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 12:13:26PM +0100, Stefano Stabellini wrote:
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

> ---
>  MAINTAINERS |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fdc0119..3d38291 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7752,6 +7752,13 @@ F:	drivers/xen/
>  F:	arch/x86/include/asm/xen/
>  F:	include/xen/
>  
> +XEN HYPERVISOR ARM
> +M:	Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> +L:	xen-devel at lists.xensource.com (moderated for non-subscribers)
> +S:	Supported
> +F:	arch/arm/xen/
> +F:	arch/arm/include/asm/xen/
> +
>  XEN NETWORK BACKEND DRIVER
>  M:	Ian Campbell <ian.campbell@citrix.com>
>  L:	xen-devel at lists.xensource.com (moderated for non-subscribers)
> -- 
> 1.7.2.5
