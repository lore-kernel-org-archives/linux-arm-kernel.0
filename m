From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Apr 2016 01:31:28 +0200
Subject: [PATCH v2] ARM: dts: artpec: update clock bindings in artpec6.dtsi
In-Reply-To: <1457946103-13853-1-git-send-email-larper@axis.com>
References: <1457946103-13853-1-git-send-email-larper@axis.com>
Message-ID: <201604240131.28836.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 March 2016, Lars Persson wrote:
> The clock binding for the main clock controller was changed to an
> indexed controller style binding on request of the clk
> maintainers. This updates the dtsi to use the new bindings.
> 
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
> v2: Use numerical clock indexes to enable merge before the clock driver bindings
> are in the tree.
> 
>  arch/arm/boot/dts/artpec6.dtsi | 99 +++++++++---------------------------------
>  1 file changed, 20 insertions(+), 79 deletions(-)

I found this patch while going through stuff that had not been applied yet.
Is this still the latest version that we should apply for v4.7?

	Arnd
