From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Jan 2017 16:47:25 +0100
Subject: [GIT PULL] i.MX fixes for 4.10, 3rd round
In-Reply-To: <20170126154630.GE5662@dragon>
References: <20170126154630.GE5662@dragon>
Message-ID: <3053667.BlQ2AN0t29@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 26, 2017 11:46:32 PM CET Shawn Guo wrote:
> i.MX fixes for 4.10, 3rd round:
>  - Fix a 'defined but not used' warning in MMDC driver when
>    CONFIG_PERF_EVENTS is disabled.
>  - Fix i.MX6DL device tree GPIO4_11 range setting.
>  - A bandaid fix for boot failure found on a couple of platforms due to
>    missing 'chosen' and 'memory' node.
> 

Pulled into fixes, thanks!

	Arnd
