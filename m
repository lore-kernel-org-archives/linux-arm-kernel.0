From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 24 Oct 2014 08:08:15 +0200
Subject: [PATCH v2] MAINTAINERS: Add myself as reviewer for Zynq
In-Reply-To: <1414081762-28886-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1414081762-28886-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <93a573b450ca429cad3ba42f875880d7@BL2FFO11FD051.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2014 06:29 PM, Soren Brinkmann wrote:
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> v2:
>  - I removed the additional 'F' entries
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0484f2c526f0..8b49eeee5a27 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1543,6 +1543,7 @@ F:	arch/arm/mach-pxa/include/mach/z2.h
>  
>  ARM/ZYNQ ARCHITECTURE
>  M:	Michal Simek <michal.simek@xilinx.com>
> +R:	S?ren Brinkmann <soren.brinkmann@xilinx.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  W:	http://wiki.xilinx.com
>  T:	git git://git.xilinx.com/linux-xlnx.git
> 

Applied.
IMHO: This can go through arm-soc tree.

Thanks,
Michal
