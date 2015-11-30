From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 13:44:03 -0800
Subject: [PATCH 0/2] adding spi alias for qspi
In-Reply-To: <1447916462-1007-1-git-send-email-mugunthanvnm@ti.com>
References: <1447916462-1007-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20151130214403.GB23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mugunthan V N <mugunthanvnm@ti.com> [151118 23:02]:
> Adding missed spi alias for qspi which helps probe the qspi
> device in U-Boot.
> 
> Mugunthan V N (2):
>   dts: dra7: add spi alias for qspi
>   arm: dts: am4372: add spi alias for qspi
> 
>  arch/arm/boot/dts/am4372.dtsi | 1 +
>  arch/arm/boot/dts/dra7.dtsi   | 1 +
>  2 files changed, 2 insertions(+)

Applying both into omap-for-v4.5/dt thanks.

Tony
