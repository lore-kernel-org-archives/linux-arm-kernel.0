From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 26 Aug 2016 11:07:34 +0200
Subject: [PATCH 1/1 linux-next] ARM: mvebu_v5_defconfig: use MV88E6XXX
In-Reply-To: <1471038438-12632-1-git-send-email-fabf@skynet.be> (Fabian
 Frederick's message of "Fri, 12 Aug 2016 23:47:18 +0200")
References: <1471038438-12632-1-git-send-email-fabf@skynet.be>
Message-ID: <8737lrkieh.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabian,
 
 On ven., ao?t 12 2016, Fabian Frederick <fabf@skynet.be> wrote:

> Commit f81ec90fe9cb
> ("net: dsa: mv88e6xxx: factorize the switch driver")
>
> merged
> CONFIG_NET_DSA_MV88E6131
> CONFIG_NET_DSA_MV88E6123
> CONFIG_NET_DSA_MV88E6171
> CONFIG_NET_DSA_MV88E6352
> to
> CONFIG_NET_DSA_MV88E6XXX
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Applied on mvebu/defconfig

Thanks,

Gregory
> ---
>  arch/arm/configs/mvebu_v5_defconfig | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index 6051c51..f7f6039 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -91,10 +91,7 @@ CONFIG_SATA_AHCI=y
>  CONFIG_SATA_MV=y
>  CONFIG_NETDEVICES=y
>  CONFIG_NET_DSA_MV88E6060=y
> -CONFIG_NET_DSA_MV88E6131=y
> -CONFIG_NET_DSA_MV88E6123=y
> -CONFIG_NET_DSA_MV88E6171=y
> -CONFIG_NET_DSA_MV88E6352=y
> +CONFIG_NET_DSA_MV88E6XXX=y
>  CONFIG_MV643XX_ETH=y
>  CONFIG_R8169=y
>  CONFIG_MARVELL_PHY=y
> -- 
> 2.8.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
