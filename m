From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 17:14:17 +0200
Subject: [GIT PULL] omap fixes against v4.3-rc5
In-Reply-To: <20151014200336.GJ10113@atomide.com>
References: <20151014200336.GJ10113@atomide.com>
Message-ID: <6230685.TX0FKXpebS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 October 2015 13:03:36 Tony Lindgren wrote:
> Fixes for omap against v4.3-rc5:
> 
> - Regulator fix for beagle-x15 to fix HDMI without a SD card being
>   inserted
> 
> - GPMC fix for showing proper timings and to allow enabling debug
>   options that somehow was unselectable earlier
> 
> - Add minimal documentation for new MMC1 dependency on
>   REGULATOR_PBIAS as it may not be obvious for people with
>   targeted .config files
> 

Pulled into fixes, thanks!

	Arnd
