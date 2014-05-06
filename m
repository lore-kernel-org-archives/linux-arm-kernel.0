From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 May 2014 11:20:19 +0900
Subject: [PATCH] ARM: dts: exynos4: Update camera nodes for Trats2 board
In-Reply-To: <1397226348-29907-1-git-send-email-s.nawrocki@samsung.com>
References: <1397226348-29907-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <07c701cf68d1$b9e59c40$2db0d4c0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Remove unused /camera/clock-controller node and add required clock
> properties to the camera node. This is required for a clock provider
> that will be referenced by image sensor devices.
> Also add required clock related changes to s5k6a3 device node and
> afvdd regulator supply.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4.dtsi          |    6 ++----
>  arch/arm/boot/dts/exynos4412-trats2.dts |    5 +++--
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
Applied, thanks.

- Kukjin
