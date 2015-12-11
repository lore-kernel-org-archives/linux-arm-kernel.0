From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Fri, 11 Dec 2015 08:51:38 -0600
Subject: [PATCH] MAINTAINERS: Add missing platform maintainers for dts
 files
In-Reply-To: <1449790703-12054-1-git-send-email-robh@kernel.org>
References: <1449790703-12054-1-git-send-email-robh@kernel.org>
Message-ID: <alpine.DEB.2.02.1512110849540.27904@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Dec 2015, Rob Herring wrote:

> Platform dts files need to be reviewed primarily by the platform
> maintainers as dts files typically go in thru their trees. Add the missing
> paths where there are existing maintainers listed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  MAINTAINERS | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
[...] 
> @@ -1536,6 +1549,7 @@ S:	Maintained
>  F:	arch/arm/mach-socfpga/
>  F:	arch/arm/boot/dts/socfpga*
>  F:	arch/arm/configs/socfpga_defconfig
> +F:	arch/arm64/boot/dts/altera/
>  W:	http://www.rocketboards.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git

Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>

Thanks,
Dinh
