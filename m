From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Oct 2013 16:51:16 +0000
Subject: [PATCH] Documentation/Changes: update binutils version
 requirement for ARMv7 builds
In-Reply-To: <alpine.DEB.2.02.1310300923080.12006@tamien>
References: <alpine.DEB.2.02.1310300923080.12006@tamien>
Message-ID: <20131030165116.GG16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 09:27:07AM -0700, Paul Walmsley wrote:
>
> ARMv7 builds now make use of the pldw opcode and the ".arch_extension mp"
> pragma.  These aren't supported in binutils prior to 2.21.  So, update
> Documentation/Changes accordingly.
>
> Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>

You can drop this Cc: line, thanks.

> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> ---
> Intended for 3.13.
>
>  Documentation/Changes | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/Changes b/Documentation/Changes
> index b175808..97fcbdf 100644
> --- a/Documentation/Changes
> +++ b/Documentation/Changes
> @@ -67,6 +67,9 @@ assembling the 16-bit boot code, removing the need for as86 to compile
>  your kernel.  This change does, however, mean that you need a recent
>  release of binutils.
>
> +ARMv7 builds require binutils 2.21 or later due to the use of the pldw
> +opcode and ".arch_extension mp".
> +
>  Perl
>  ----
>
> -- 
> 1.8.1.5
>
