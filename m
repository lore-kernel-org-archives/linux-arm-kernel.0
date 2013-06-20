From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 16:56:20 +0200
Subject: [GIT PULL 2/7] omap serial pm cleanup for v3.11 merge window
In-Reply-To: <0Lwpku-1UDWoh3rPk-016pC6@mx.kundenserver.de>
References: <0Lwpku-1UDWoh3rPk-016pC6@mx.kundenserver.de>
Message-ID: <201306201656.20614.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Tony Lindgren wrote:
> The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:
> 
>   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/pm-serial-signed
> 
> for you to fetch changes up to 1e383d7bdd988b1453a3a86f5e14b012700f7dff:
> 
>   Merge tag 'omap-pm-v3.11/cleanup/pm' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.11/pm-serial (2013-06-17 04:03:14 -0700)
> 
> ----------------------------------------------------------------
> 
> Serial driver platform init code clean-up via Kevin Hilman <khilman@linaro.org>:
> 
> OMAP: PM: the serial core + driver can no handle no_console_suspend support
> without any SoC specific handlding or SoC-specific DT bindings.  Remove
> the now unused SoC specifics for OMAP.
> 

Pulled into next/cleanup, thanks!
	
	Arnd
