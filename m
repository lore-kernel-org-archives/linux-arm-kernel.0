From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 14:29:11 +0100
Subject: [PATCH 0/4] Consolidate Exynos machine code
In-Reply-To: <1395231957-22032-1-git-send-email-sachin.kamat@linaro.org>
References: <1395231957-22032-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <201403191429.11721.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 March 2014, Sachin Kamat wrote:
> This patch series consolidates the Exynos machine code and common
> code into a single file to avoid code duplication and introduces
> generic compatible strings for Exynos4 and 5 SoC series.
> 
> Complete discussion and motivation for this series is found here:
> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/27268
> 
> This series is based on the latest linux-next and depends on
> 1. Tomasz Figa's PM consolidation series 1 and 2
> 2. Patch: ARM: SAMSUNG: Reorganize calls to reserve memory for MFC
> http://www.spinics.net/lists/linux-samsung-soc/msg25501.html
> 3. Patch: ARM: EXYNOS: Add support to reserve memory for MFC-v7
> http://www.spinics.net/lists/arm-kernel/msg315940.html
> 4. Kconfig and CPU init Consolidation series
> http://article.gmane.org/gmane.linux.kernel.samsung-soc/28216

Acked-by: Arnd Bergmann <arnd@arndb.de>
