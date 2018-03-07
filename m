From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 16:15:26 +0100
Subject: [GIT PULL 1/6] omap soc changes for v4.17
In-Reply-To: <pull-1520273005-304551@atomide.com>
References: <pull-1520273005-304551@atomide.com>
Message-ID: <CAK8P3a0=1=Y_rGbBPDHRmU=FkfTQRnMNkGuP8jrP6LSoe8BNWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 5, 2018 at 7:11 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit fe27f16794f313f5fc16f6d2f42d8c2b2f4d70cc:
>
>   ARM: OMAP2+: Fix sar_base inititalization for HS omaps (2018-02-14 08:35:14 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/soc-signed
>
> for you to fetch changes up to e33509c19da5931e4363c85f6e83bd11803ba121:
>
>   ARM: OMAP2+: Fix typo for wakeup_ns_pa_addr (2018-02-28 14:47:13 -0800)
>
> ----------------------------------------------------------------
> SoC changes for omaps for v4.17
>
> This series is mostly a series from Suman Anna to remove now unused
> platform data that is now coming from device tree. This also make it
> a bit simpler to move the timer code to live under drivers in a
> separate series of patches. There are also few minor clean-ups for
> omap4 PM code.

Nice cleanup! Pulled into next/soc now, thanks!

       Arnd
