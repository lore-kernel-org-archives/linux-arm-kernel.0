From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 09 Jul 2015 15:39:27 -0700
Subject: [GIT PULL] omap fixes against v4.2-rc1
In-Reply-To: <20150709094130.GK10644@atomide.com> (Tony Lindgren's message of
 "Thu, 9 Jul 2015 02:41:30 -0700")
References: <20150709094130.GK10644@atomide.com>
Message-ID: <7hio9tarc0.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
>
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/fixes-rc1
>
> for you to fetch changes up to ae745302c0a3e2b5b768690f631fc14db44467e7:
>
>   Merge branch 'fixes-rc1' into omap-for-v4.2/fixes (2015-07-06 05:33:17 -0700)
>
> ----------------------------------------------------------------
> Minor fixes for omaps against v4.2-rc1. Mostly just minor dts changes
> except for a GPMC fix to not use names for probing devices. Also a
> one liner clean-up to remove unecessary return from a void function.
>
> The summary for the changes being:
>
> - Fix probe for GPMC devices by reoving limitations based on device
>   name
>
> - Remove unnecessary return from a void function
>
> - Revert beaglebone RTC sleep fix, we now have a better fix merged
>
> - Add am4372 EMIF node to fix a warning
>
> - Add am57xx-beagle-x15 power supply to fix USB2 if USB1 is disabled
>
> - Disable rfbi for am4372 as it does not have a driver
>
> ----------------------------------------------------------------

Pulled into fixes,

Thanks,

Kevin
