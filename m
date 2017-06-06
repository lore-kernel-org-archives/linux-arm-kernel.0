From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Jun 2017 00:34:23 -0700
Subject: [PATCH] arm: dts: am33xx: Remove redundant interrupt-parent
 property
In-Reply-To: <1496686636-19194-1-git-send-email-sunil.m@techveda.org>
References: <1496686636-19194-1-git-send-email-sunil.m@techveda.org>
Message-ID: <20170606073422.GX3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* sunil.m at techveda.org <sunil.m@techveda.org> [170605 11:21]:
> From: Suniel Mahesh <sunil.m@techveda.org>
> 
> Interrupt-parent property is defined in the root node as
> "interrupt-parent = <&intc>". This interrupt-parent value becomes
> the default for the system, so removed redundant "interrupt-parent"
> property from mmc, mac, lcdc and tscadc nodes.

Thanks seems safe to remove so applying into omap-for-v4.13/dt.

Tony
