From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 12 Apr 2017 10:36:48 +0200
Subject: [PATCH 5/7] arm64: marvell: dts: enable the crypto engine on the
 Armada 7040 DB
In-Reply-To: <20170329124432.27457-6-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Wed, 29 Mar 2017 14:44:30 +0200")
References: <20170329124432.27457-1-antoine.tenart@free-electrons.com>
 <20170329124432.27457-6-antoine.tenart@free-electrons.com>
Message-ID: <871ssyhvj3.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On mer., mars 29 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Enable the cryptographic engine available in the CP110 master on the
> Armada 7040 DB.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>


Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> index bb0e1e8e7138..7e9a8a4e89a4 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -171,3 +171,7 @@
>  	phy = <&phy1>;
>  	phy-mode = "rgmii-id";
>  };
> +
> +&cpm_crypto {
> +	status = "okay";
> +};
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
