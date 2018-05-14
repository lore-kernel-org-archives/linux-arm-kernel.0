From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 01:19:20 -0700
Subject: [GIT PULL 1/3] ti-sysc driver changes for v4.18 merge window
In-Reply-To: <pull-1525450571-674978@atomide.com>
References: <pull-1525450571-674978@atomide.com>
Message-ID: <20180514081920.ahyt6hwkkyex3ffw@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 09:17:31AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/ti-sysc-signed
> 
> for you to fetch changes up to dc4c85eac6bc8cfe25144936c5636aa1415bbc12:
> 
>   bus: ti-sysc: Show module information for suspend if DEBUG is enabled (2018-05-01 06:54:17 -0700)
> 
> ----------------------------------------------------------------
> ti-sysc driver related changes for omap variants
> 
> This series improves the ti-sysc interconnect target module driver to
> the point where a most of SoC can be booted with interconnect target
> module data configured in device tree instead of legacy platform data.
> The related device tree changes need some more work though, and can
> wait for v4.19. Also some drivers using nested interconnects like DSS
> need more work.
> 
> We can now remove the unused pm-noop code that is not doing anything
> any longer. And we can now initialize things for PM and display pdata
> later to prepare things for using ti-sysc driver.
> 
> We also need to add  some more quirk handling so we can boot both with
> platform data and dts data.

Merged, thanks!


-Olof
