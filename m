From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jun 2013 04:03:45 -0700
Subject: [GIT PULL] OMAP: PM: remove OMAP-specific no_console_suspend
 handling
In-Reply-To: <87zjutacec.fsf@linaro.org>
References: <87zjutacec.fsf@linaro.org>
Message-ID: <20130617110344.GP20992@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@linaro.org> [130613 15:18]:
> Tony,
> 
> Please pull this OMAP PM cleanup for v3.11.
> 
> Thanks,
> 
> Kevin
> 
> The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:
> 
>   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.11/cleanup/pm
> 
> for you to fetch changes up to 4b7ec5accecdb136c7afaf8739a06d5335cc05aa:
> 
>   arm: omap2+: omap_device: remove no_idle_on_suspend (2013-05-16 07:09:09 -0700)
> 
> ----------------------------------------------------------------
> OMAP: PM: the serial core + driver can no handle no_console_suspend support
> without any SoC specific handlding or SoC-specific DT bindings.  Remove
> the now unused SoC specifics for OMAP.

Thanks pulling into omap-for-v3.11/pm-serial.

Regards,

Tony
