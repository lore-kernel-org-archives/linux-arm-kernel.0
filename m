From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 30 May 2017 12:07:23 +0200
Subject: [PATCH 1/3] arm64: dts: rockchip: bring rk3399-firefly power-tree
 in line
In-Reply-To: <20170523095427.7421-1-heiko@sntech.de>
References: <20170523095427.7421-1-heiko@sntech.de>
Message-ID: <2924720.omGovoX6XK@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 23. Mai 2017, 11:54:25 CEST schrieb Heiko Stuebner:
> The power-tree on the rk3399-firefly did not completely match the
> documentation and vendor devicetree. It was also missing some
> supply-hirarchy information and some regulator-gpio names did not
> match the schematics. Fix this for the existing regulators before
> introducing new things.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied all 3 for 4.13, with the ethernet alias changed to ethernet0
as suggested


Heiko
