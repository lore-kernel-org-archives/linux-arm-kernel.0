From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 06 Jan 2017 22:46:45 +0100
Subject: [PATCH v3 0/3] Rockchip: generalize GRF setup
In-Reply-To: <20161116230304.8432-1-heiko@sntech.de>
References: <20161116230304.8432-1-heiko@sntech.de>
Message-ID: <4525397.n2uf8fF4JB@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 17. November 2016, 00:03:01 CET schrieb Heiko Stuebner:
> The General register files contain a big bunch of settings for various
> components. Things like the automatic sdmmc/jtag switch may even affect
> us in a bad way, while that property (and possibly others) are not even
> part of the dw_mmc controller itself.
> 
> And while the rk3288 could still carry adaptions to these defaults
> in its mach files, this is no longer possible on the arm64 socs, while
> things like the jtag-switch from above still can affect us there.

applied these 3 to my drivers branch for 4.11
