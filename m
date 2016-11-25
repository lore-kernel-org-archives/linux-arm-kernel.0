From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Nov 2016 00:01:20 +0100
Subject: [GIT PULL] ARM: OXNAS SoC DT updates for 4.10
In-Reply-To: <85ecb958-a6cb-bdd2-10db-873e1b894ad7@baylibre.com>
References: <85ecb958-a6cb-bdd2-10db-873e1b894ad7@baylibre.com>
Message-ID: <7834199.K9ccmT5zgF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 4, 2016 11:26:30 AM CET Neil Armstrong wrote:
> - Add DTSI for Oxford Semiconductor OX820
> - Add DTS for Cloud Engines PogoPlug v3 board
> - Fix MAINTAINERS Oxnas entry for dts files
> from http://lkml.kernel.org/r/20161102141850.25164-1-narmstrong at baylibre.com
> 
> 

This one seemed to have gone missing after Olof asked for a respin
of the other oxnas branch. I've pulled it into next/dt now.

I'd probably have put the MAINTAINERS update into a different
branch (possibly even for v4.9), but it doesn't seem too important
since there was no change in the maintainers and it's unlikely
to cause conflicts.

	Arnd
