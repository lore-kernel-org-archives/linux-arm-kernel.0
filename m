From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Sep 2016 16:05:44 +0200
Subject: [PATCH 0/3] ARM: dts: artpec6.dtsi updates
In-Reply-To: <cover.1471959733.git.larper@axis.com>
References: <cover.1471959733.git.larper@axis.com>
Message-ID: <2398929.KttRDJeEu5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 23, 2016 4:00:49 PM CEST Lars Persson wrote:
> This brings the dtsi up to date with with tested and optimized settings from the
> Axis tree.
> 
> Lars Persson (3):
>   ARM: dts: artpec: use clock binding header
>   ARM: dts: artpec: use optimized pl310 settings
>   ARM: dts: artpec: set irq affinity on pmu interrupts
> 
>  arch/arm/boot/dts/artpec6.dtsi | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> 

Applied all three to next/dt, thanks for your patience and sorry
for the delay on my side.

	Arnd
