From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 15:43:53 +0100
Subject: [PATCH] arm64: dts: berlin4ct: switch to Cortex-A53 specific pmu
 nodes
In-Reply-To: <1450190172-1161-1-git-send-email-jszhang@marvell.com>
References: <1450190172-1161-1-git-send-email-jszhang@marvell.com>
Message-ID: <8261316.NuheDtlQ6N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 December 2015 22:36:12 Jisheng Zhang wrote:
> -               compatible = "arm,armv8-pmuv3";
> +               compatible = "arm,cortex-a53-pmu";
> 

Should this list both?

	Arnd
