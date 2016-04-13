From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 10:54:04 -0700
Subject: [PATCH 0/3] ARM: OXNAS pull request for 4.7
In-Reply-To: <1459521689-13962-1-git-send-email-narmstrong@baylibre.com>
References: <1459521689-13962-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160413175404.GF19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 04:41:29PM +0200, Neil Armstrong wrote:
> This is the ARM pull request for the OXNAS platform.
> It also includes one-line change into irq-versatile-fpga.
> 
> The following changes since commit 1e6d88ccf41c7ef2d6c99aa5e7fb9215aa0e5423:
> 
>   Merge tag 'nios2-v4.6-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2 (2016-03-30 20:40:42 -0500)
> 
> are available in the git repository at:
> 
>   https://github.com/superna9999/linux.git tags/ox810se-arm
> 
> for you to fetch changes up to b4f122cdd148696e0d8c5f815ac48c5b9ed9de3f:
> 
>   MAINTAINERS: add maintainer entry for ARM/OXNAS platform (2016-04-01 15:51:54 +0200)
> 
> ----------------------------------------------------------------
> ARM: Add OXNAS Platform Support
> 
> Changes since original v3 patchset :
> - Get rid of PLX Technology
> 
> v3 patchset : http://lkml.kernel.org/r/1458838215-23314-1-git-send-email-narmstrong at baylibre.com

Hi Neil,

This branch seems to start from an arbitrary point and not an -rc. We want
branches only starting at -rc releases, please.

For a new platform like this, while patch volume is low, it might be easier to
just submit patches that we apply directly.

Some further questions: We usually try to add mach directories per vendor so we
don't get large number of them. Would it make sense to call it something else
than OxNAS here? I saw some patches posted referring to PLX instead of Oxford
Semi as well. What's up with that?

There's an overall lack of documentation of the platform in the initial patches
as well. An overview of it, maybe with links to product information, etc, is
useful.



-Olof
