From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 19:21:35 -0700
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Fixes for v4.12
In-Reply-To: <cover.1497259417.git.horms+renesas@verge.net.au>
References: <cover.1497259417.git.horms+renesas@verge.net.au>
Message-ID: <20170619022135.GU30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 12, 2017 at 11:27:22AM +0200, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC fixes for v4.12.
> 
> It splits LCD mux and gpio into separate nodes as different values
> for the output-high property are required.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-fixes-for-v4.12,
> which I have already sent a pull-request for.
> 
> 
> The following changes since commit 7b4ccb3c466f62bbf2f4dd5d6a143d945a6f3051:
> 
>   soc: renesas: Provide dummy rcar_rst_read_mode_pins() for compile-testing (2017-04-28 10:07:36 +0200)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes2-for-v4.12
> 
> for you to fetch changes up to 13132b3f44d3600983aceb7e9920b8ebb55a7cf8:
> 
>   ARM: dts: armadillo800eva: Split LCD mux and gpio (2017-06-08 15:44:55 +0200)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC Fixes for v4.12
> 
> * Split LCD mux and gpio on armadillo800eva board

So, Geert wrote a great patch description as to why this patch is
important as a fix, but none of that made it into the pull request.

When you have the write-up already available, and especially this late in the
release cycle, it'd really be preferred to have it make it into the tag
description. As always, documentation of the _why_ is a lot more important than
the _what_.

Merged into fixes-non-critical for the v4.13 merge window, since the
fixed commit is two years old and thus doesn't seem like an urgent fix.

Note that this means that any new fixes that are indeed urgent can't be based
on this branch, they need to be sent independently.


Thanks,

-Olof
