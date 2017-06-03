From: oss@buserror.net (Scott Wood)
Date: Fri, 02 Jun 2017 19:12:34 -0500
Subject: [PATCH 1/2] MAINTAINERS: update entry for Freescale SoC drivers
In-Reply-To: <1496445623-22390-1-git-send-email-leoyang.li@nxp.com>
References: <1496445623-22390-1-git-send-email-leoyang.li@nxp.com>
Message-ID: <1496448754.29095.17.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-06-02 at 18:20 -0500, Li Yang wrote:
> Add myself as the maintainer for drivers/fsl/soc/ and fix the scope for
> device tree bindings.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
> ?MAINTAINERS | 5 +++--
> ?1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d24240b..1807d3f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5357,11 +5357,11 @@ S:	Maintained
> ?F:	drivers/net/ethernet/freescale/dpaa
> ?
> ?FREESCALE SOC DRIVERS
> -M:	Scott Wood <oss@buserror.net>
> +M:	Li Yang <leoyang.li@nxp.com>
> ?L:	linuxppc-dev at lists.ozlabs.org
> ?L:	linux-arm-kernel at lists.infradead.org
> ?S:	Maintained
> -F:	Documentation/devicetree/bindings/powerpc/fsl/
> +F:	Documentation/devicetree/bindings/soc/fsl/
> ?F:	drivers/soc/fsl/
> ?F:	include/linux/fsl/
> ?
> @@ -7695,6 +7695,7 @@ T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
> ?S:	Maintained
> ?F:	arch/powerpc/platforms/83xx/
> ?F:	arch/powerpc/platforms/85xx/
> +F:	Documentation/devicetree/bindings/powerpc/fsl/
> ?
> ?LINUX FOR POWERPC PA SEMI PWRFICIENT
> ?L:	linuxppc-dev at lists.ozlabs.org

Acked-by: Scott Wood <oss@buserror.net>

-Scott
