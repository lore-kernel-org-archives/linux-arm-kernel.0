From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 18:28:44 +0200
Subject: [PATCH 3/6] ARM: berlin: add the AHCI node for the BG2Q
In-Reply-To: <1398181105-19714-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140422182844.3f2eb558@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Antoine T?nart,

On Tue, 22 Apr 2014 17:38:22 +0200, Antoine T?nart wrote:

> +		ahci: sata at e90000 {
> +			compatible = "marvell,berlin-ahci";
> +			reg = <0xe90000 0x10000>;
> +			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disable";

Should be:

			status = "disabled";

And ditto for patches 5 and 6.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
