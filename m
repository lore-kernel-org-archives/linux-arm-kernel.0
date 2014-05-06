From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 May 2014 11:19:40 +0900
Subject: [PATCH] ARM: dts: Add rear camera nodes for Exynos4412 Trats2
 board
In-Reply-To: <1397226303-29844-1-git-send-email-s.nawrocki@samsung.com>
References: <1397226303-29844-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <07ba01cf68d1$a2d47580$e87d6080$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> This patch enables the rear facing camera (s5c73m3) on TRATS2 board
> by adding the I2C0 bus controller, s5c73m3 sensor, MIPI CSI-2 receiver
> and the sensor's voltage regulator supply nodes.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-trats2.dts |   72
> +++++++++++++++++++++++++++++--
>  1 file changed, 69 insertions(+), 3 deletions(-)
> 
Applied, thanks.

- Kukjin
