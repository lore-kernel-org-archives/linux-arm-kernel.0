From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 07 Mar 2014 11:07:51 +0100
Subject: [PATCH v6 09/10] ARM: dts: Add rear camera nodes for Exynos4412
 TRATS2 board
In-Reply-To: <1394122819-9582-10-git-send-email-s.nawrocki@samsung.com>
References: <1394122819-9582-1-git-send-email-s.nawrocki@samsung.com>
 <1394122819-9582-10-git-send-email-s.nawrocki@samsung.com>
Message-ID: <53199A77.9090602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 06/03/14 17:20, Sylwester Nawrocki wrote:
> This patch enables the rear facing camera (s5c73m3) on TRATS2 board
> by adding the I2C0 bus controller, s5c73m3 sensor, MIPI CSI-2 receiver
> and the sensor's voltage regulator supply nodes.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Could still patches 9, 10 be queued for v3.15, or is arm-soc
already closed for this merge windiw ?

--
Thanks,
Sylwester
