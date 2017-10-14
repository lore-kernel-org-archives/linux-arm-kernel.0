From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 14 Oct 2017 21:30:48 +0200
Subject: [PATCH 1/9] clk: rockchip: add more rk3188 graphics clock ids
In-Reply-To: <20170915083357.11296-2-heiko@sntech.de>
References: <20170915083357.11296-1-heiko@sntech.de>
 <20170915083357.11296-2-heiko@sntech.de>
Message-ID: <5386849.LLMIu0zLOz@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. September 2017, 10:33:49 CEST schrieb Heiko Stuebner:
> Add ids for cif, v{d/e}pu clocks on rk3188. ACLK_CIF does get a needed
> 1 at it's end but that should be safe because no driver for the camera
> interface has surfaced so far and the old vendor kernels for these socs
> are based on linux-3.0 and still used board files then, so there really
> are no previous users anywhere to be found.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied for 4.15
