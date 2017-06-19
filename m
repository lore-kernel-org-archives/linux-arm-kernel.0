From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 19:03:54 -0700
Subject: [GIT PULL] Reset controller changes for v4.13
In-Reply-To: <1496050098.17695.31.camel@pengutronix.de>
References: <1496050098.17695.31.camel@pengutronix.de>
Message-ID: <20170619020354.GF30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 29, 2017 at 11:28:18AM +0200, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> please consider merging this tag for v4.13, which adds a new Gemini
> reset driver, cleans up array allocation in the sti/reset-syscfg driver,
> and renames the ti_syscon Kconfig symbol to align with the others.

I saw part two come in, and had never seen part one. Seems like you sent it to
the wrong address (arm-soc at kernel.org, not arm at kernel.org), so I missed it.

> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.13
> 
> for you to fetch changes up to 2acb037fc42b8ce5ae59a7d5db3c9b35672e3dd7:
> 
>   reset: Add a Gemini reset controller (2017-05-24 10:46:13 +0200)

Merged, thanks.


-Olof
