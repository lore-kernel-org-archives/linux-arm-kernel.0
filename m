From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 4 Jun 2013 10:25:12 +0100
Subject: [PATCH v2 4/5] arm64/xen: use XEN_IO_PROTO_ABI_ARM on ARM64
In-Reply-To: <1370273624-26976-4-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1306031157020.4589@kaball.uk.xensource.com>
 <1370273624-26976-4-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1370337912.24512.91.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-06-03 at 16:33 +0100, Stefano Stabellini wrote:
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Acked-by: Ian Campbell <ian.campbell@citrix.com>

> ---
>  include/xen/interface/io/protocols.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/xen/interface/io/protocols.h b/include/xen/interface/io/protocols.h
> index 0eafaf2..056744b 100644
> --- a/include/xen/interface/io/protocols.h
> +++ b/include/xen/interface/io/protocols.h
> @@ -15,7 +15,7 @@
>  # define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_IA64
>  #elif defined(__powerpc64__)
>  # define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_POWERPC64
> -#elif defined(__arm__)
> +#elif defined(__arm__) || defined(__aarch64__)
>  # define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_ARM
>  #else
>  # error arch fixup needed here
