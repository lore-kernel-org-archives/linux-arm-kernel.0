From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 26 Apr 2017 02:49:07 +0200
Subject: [PATCH v2 2/2] ARM: dts: Add the ethernet and ethernet PHY to
 the cygnus core DT.
In-Reply-To: <20170425235357.7690-2-eric@anholt.net>
References: <20170425235357.7690-1-eric@anholt.net>
 <20170425235357.7690-2-eric@anholt.net>
Message-ID: <20170426004907.GA9453@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		eth0: ethernet at 18042000 {
> +			compatible = "brcm,amac";
> +			reg = <0x18042000 0x1000>,
> +			      <0x18110000 0x1000>;
> +			reg-names = "amac_base", "idm_base";
> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +			max-speed = <1000>;

Hi Eric

Sorry i missed this the first time. Does this Ethernet controller do >
1Gbps? Does this max-speed do anything useful?

       Andrew
