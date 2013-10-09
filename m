From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 09 Oct 2013 13:42:10 -0700
Subject: [GIT PULL] omap fixes against v3.12-rc3
In-Reply-To: <20131008220324.GV8313@atomide.com> (Tony Lindgren's message of
 "Tue, 8 Oct 2013 15:03:24 -0700")
References: <20131008220324.GV8313@atomide.com>
Message-ID: <87d2netbvh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:
>
>   Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-against-v3.12-rc3-take2
>
> for you to fetch changes up to d1f1ca36b566aa56effdd7df69750062ec735131:
>
>   ARM: OMAP2: RX-51: Add missing max_current to rx51_lp5523_led_config (2013-10-08 11:22:43 -0700)
>
> ----------------------------------------------------------------
> Few fixes for omap3 related hangs and errors that people have
> noticed now that people are actually using the device tree
> based booting for omap3.

FWIW, my automated boot is doing only DT boots on all the OMAP
platforms.  However, it's only testing basic boot so far so there's not
a whole lot of driver testing yet (but it's coming soon.)

> Also one regression fix for timer compile for dra7xx when
> omap5 is not selected, and a LED regression fix for n900.

Thanks, pulled into fixes.

Kevin
