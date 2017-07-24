From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 24 Jul 2017 22:56:28 +0200
Subject: [PATCH v5 0/3] some fixups for MediaTek cpufreq driver
In-Reply-To: <cover.1500355954.git.sean.wang@mediatek.com>
References: <cover.1500355954.git.sean.wang@mediatek.com>
Message-ID: <1941970.gMtimJUdWe@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 18, 2017 02:01:42 PM sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Changes since v4:
> - add back the missing Acked-by from v3
> 
> Changes since v3:
> - remove the redundant line depends on ARM || ARM64 || COMPILE_TEST
> since the whole Kconfig.arm file depends on ARM || ARM64.
> - renaming from mtk-cpufreq.c to mediatek-cpufreq.c avoiding
> collide and cause confusion at some point in time.
> 
> Changes since v2:
> - correct the typo in the binding document
> 
> Changes since v1:
> - drop those patches already accepted
> - refine the commit messages and Kconfig dependency
> - Kconfig menu entry and file name itself are updated with more
> generic name to drop "MT8173" since this driver actually supports
> all MediaTek SoCs.
> - generate patchset again with git format-patch -C -M --thread=shallow
> - fix binding examples by replacing '@' with '-' as the OPP nodes will
> never have a "reg" property.
> 
> Hi,
> 
> The purpose of the series is
> - (patch 1 to 3) to fix up current Mediatek cpufreq driver
> can't work with the latest tree since one required CPU clock muxer missing
> would cause the driver getting the resource fails when driver probe gets
> called.
> - (patch 4) to enable cpufreq feature on MT2701/MT7623 platform.
> - (patch 5 to 6) to update the binding document to reflect
> latest driver logic and add more examples guiding people how to apply for
> Mediatek cpufreq driver.
> 
> Sean Wang (3):
>   cpufreq: mediatek: Add support of cpufreq to MT2701/MT7623 SoC
>   dt-bindings: cpufreq: move MediaTek cpufreq dt-bindings document to
>     proper place
>   dt-bindings: cpufreq: enhance MediaTek cpufreq dt-binding document

Series applied, thanks!
