From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 00:01:46 +0200
Subject: [PATCH v2] ARM: dts: artpec: update clock bindings in artpec6.dtsi
In-Reply-To: <1457946103-13853-1-git-send-email-larper@axis.com>
References: <1457946103-13853-1-git-send-email-larper@axis.com>
Message-ID: <8943044.6HVM79N0NL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 March 2016 10:01:43 Lars Persson wrote:
> The clock binding for the main clock controller was changed to an
> indexed controller style binding on request of the clk
> maintainers. This updates the dtsi to use the new bindings.
> 
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
> v2: Use numerical clock indexes to enable merge before the clock driver bindings
> are in the tree.
> 

Applied to next/dt for v4.7, thanks!

	Arnd
