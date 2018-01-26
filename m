From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Jan 2018 17:41:23 +0100
Subject: [GIT PULL] one ti-sysc driver fix for v4.16 merge window
In-Reply-To: <pull-1516729268-155514@atomide.com>
References: <pull-1516729268-155514@atomide.com>
Message-ID: <CAK8P3a2pqZ0=ra9q=V4uFP6Qs_DBj12sY4WXn0kutHmgL9Kwcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 6:42 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit c5a2de97fbd2979fab291fb048084d3fddd322dd:
>
>   bus: ti-sysc: Add parsing of module capabilities (2017-12-21 07:28:54 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/ti-sysc-fix-signed
>
> for you to fetch changes up to 3267c081e037e2ed1a3af65ee46825799a7ccda5:
>
>   bus: ti-sysc: Fix smartreflex sysc mask (2018-01-22 09:32:53 -0800)
>
> ----------------------------------------------------------------
> One minor fix for ti-sysc smartreflex sysc mask that prevents idling
> the smartreflex interconnect target module for device tree based
> probing.

Pulled into next/drivers, thanks!

       Arnd
