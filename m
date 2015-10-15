From: khiem.nguyen.xt@rvc.renesas.com (Khiem Nguyen)
Date: Thu, 15 Oct 2015 13:45:06 +0700
Subject: [PATCH v11 8/8] MAINTAINERS: Add entry Renesas arm64 architecture
In-Reply-To: <1444890243-6978-9-git-send-email-horms+renesas@verge.net.au>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
 <1444890243-6978-9-git-send-email-horms+renesas@verge.net.au>
Message-ID: <561F4B72.2050305@rvc.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thanks for your patch.

On 10/15/2015 1:24 PM, Simon Horman wrote:
> Initial Renesas arm64 architecture support will be for the R-Car H3,
> r8a7795, SoC and its Salvator-X board.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
>
> Changes since v10:
> - New Patch
> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ba7ab749c85..0067b7156622 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1392,6 +1392,16 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
>   L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>
> +ARM/RENESAS ARM64 ARCHITECTURE

I think you should add this near its younger brother, i.e ARM/RENESAS 
ARM ARCHITECTURE.

> +M:	Simon Horman <horms@verge.net.au>
> +M:	Magnus Damm <magnus.damm@gmail.com>
> +L:	linux-sh at vger.kernel.org
> +W:	http://oss.renesas.com

It seems the web site is closed now. There's a message "This Web Site is 
closed."
Please replace it with other web address or remove it.
In case you decide to remove it, please also remove this web under 
"ARM/SHMOBILE ARM ARCHITECTURE".

> +Q:	http://patchwork.kernel.org/project/linux-sh/list/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
> +S:	Supported
> +F:	arch/arm64/boot/dts/renesas/
> +
>   ARM/RISCPC ARCHITECTURE
>   M:	Russell King <linux@arm.linux.org.uk>
>   L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>
