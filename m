From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 07 Mar 2017 18:46:22 +0100
Subject: [PATCH] arm64: defconfig: enable MVNETA
In-Reply-To: <20170220172717.8252-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Mon, 20 Feb 2017 18:27:17 +0100")
References: <20170220172717.8252-1-gregory.clement@free-electrons.com>
Message-ID: <87mvcxnfo1.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On lun., f?vr. 20 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Now that the Armada 37xx SoCs support the mvneta driver, enable it by
> default. It is especially useful when booting on an NFS root.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/defconfig64

Gregory

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7c48028ec64a..0ebe737d3778 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -185,6 +185,7 @@ CONFIG_HNS_ENET=y
>  CONFIG_E1000E=y
>  CONFIG_IGB=y
>  CONFIG_IGBVF=y
> +CONFIG_MVNETA=y
>  CONFIG_SKY2=y
>  CONFIG_RAVB=y
>  CONFIG_SMC91X=y
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
