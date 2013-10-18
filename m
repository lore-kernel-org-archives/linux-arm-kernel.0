From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 18 Oct 2013 11:42:38 -0700
Subject: [GIT PULL 1/1] omap board removal for some omap3 boards for v3.13
 merge window
In-Reply-To: <526174c7.410be00a.37ba.ffffbc8eSMTPIN_ADDED_BROKEN@mx.google.com>
 (Tony Lindgren's message of "Fri, 18 Oct 2013 10:49:54 -0700")
References: <526174c7.410be00a.37ba.ffffbc8eSMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <87ob6mv2sh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit f41509ad0d4c11d0911630440749d409ce2aa1aa:
>
>   Merge branches 'omap-for-v3.13/dt' and 'omap-for-v3.13/quirk' into omap-for-v3.13/board-removal (2013-10-14 11:33:07 -0700)
>
> are available in the git repository at:
>
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/board-removal-signed-take2
>
> for you to fetch changes up to 06ff74fd197aa8205443cf64b94383802602e320:
>
>   ARM: OMAP2+: remove legacy support for IGEP boards (2013-10-18 10:25:46 -0700)
>
> ----------------------------------------------------------------
> Changes needed to drop legacy booting support for some
> omap3 boards.
>
> Note that that these are based on a merge of the
> following for the dependencies:
>
> - v3.12-rc5 for fixes to pinctrl mask
> - omap-for-v3.13/dt-signed to avoid pointless merge conflicts
> - omap-for-v3.13/quirk-signed for legacy pdata handling
>
> ----------------------------------------------------------------

Pulled into next/dt since the the dependencies are also in next/dt.

Thanks for the respin,

Kevin
