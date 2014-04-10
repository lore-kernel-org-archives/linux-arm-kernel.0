From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Apr 2014 11:46:16 +0200
Subject: [PATCH 03/27] ARM: EXYNOS: Add IO mapping for PMU of Exynos3250
In-Reply-To: <1397122124-15690-4-git-send-email-cw00.choi@samsung.com>
References: <1397122124-15690-1-git-send-email-cw00.choi@samsung.com>
 <1397122124-15690-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <4996376.GgWd9rnCP3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 April 2014 18:28:20 Chanwoo Choi wrote:
> This patch add memory mapping for PMU (Power Management Unit) which is used
> for power control of Exynos3250.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Same thing as for the SRAM here, can you work on making this a proper
driver instead?

	Arnd
