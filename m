From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 23:49:28 +0100
Subject: [GIT PULL] omap fixes against v4.4-rc2
In-Reply-To: <20151125223704.GV2517@atomide.com>
References: <20151125223704.GV2517@atomide.com>
Message-ID: <15820949.xv0lSuANaf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 14:37:04 Tony Lindgren wrote:
> Fixes for omaps for v4.4-rc cycle:
> 
> - A series of audio changes for dra7 that missed the merge window but turned
>   out to be necessary to fix a boot time imprecise external abort error and to
>   getaudio working
> 
> - Fix l4 related boot time errors for dm81xx
> 
> - Use lockless cldm/pwrdm api in omap4_boot_secondary
> 
> - Remove t410 custom abort handler that is no longer needed and may
>   hide other critical errors
> 
> - Mark cpuidle tracepoints as _rcuidle
> 
> - Fix module alias for omap-ocp2scp
> 

Merged into fixes, thanks!

	Arnd
