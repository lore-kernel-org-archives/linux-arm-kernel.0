From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Dec 2014 17:01:38 +0100
Subject: [PATCH 1/2] ARM: dts: kirkwood: enable phy driver for SATA
 controller on 88f6192
In-Reply-To: <20141215203724.GA22936@anne>
References: <20141215203724.GA22936@anne>
Message-ID: <20141216170138.14dcabc1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Evgeni Dobrev,

On Mon, 15 Dec 2014 21:37:24 +0100, Evgeni Dobrev wrote:
> This patch enables the phy drivers for the SATA controller on Marvell's 88f6192. Without them it is not possible to use SATA drives attached to this processor.

Commit log text should be wrapped to some reasonable length.


>  			interrupts = <21>;
>  			clocks = <&gate_clk 14>, <&gate_clk 15>;
>  			clock-names = "0", "1";
> +                        phys = <&sata_phy0>, <&sata_phy1>;
> +                        phy-names = "port0", "port1";

You should use tabs and not spaces for indentation in Device Tree files.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
