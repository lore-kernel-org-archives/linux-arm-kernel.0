From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Jul 2016 22:06:29 -0700
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates
 for v4.8
In-Reply-To: <cover.1467291676.git.horms+renesas@verge.net.au>
References: <cover.1467291676.git.horms+renesas@verge.net.au>
Message-ID: <20160707050629.GD32389@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 04:15:06PM +0200, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM64 based SoC DT updates
> for v4.8.
> 
> The support for the new r8a7796 SoC depends on clk definitions which
> I have taken the liberty of including in this branch to avoid depending
> on another branch. The definitions in question are derived from the
> datasheet and in keeping with the approach taken for other Renesas SoCs.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-arm64-dt-for-v4.8,
> which you have already pulled.
> 
> 
> The following changes since commit 21cc405c8a6332ddad2d2751a9723b2b3e227a05:
> 
>   arm64: dts: r8a7795: Drop 0x from unit address of gic (2016-05-30 10:18:01 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.8
> 
> for you to fetch changes up to 2c9616a1fc01c656f04f03feb58fa12d9b30802a:
> 
>   arm64: dts: r8a7796/salvator-x: Enable watchdog timer (2016-06-28 07:04:44 +0200)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM64 Based SoC DT Updates for v4.8
> 
> * Add support for  r8a7796/salvator-x (R-Car Gen 3 M3-W)
> * Add CAN support to r8a7795 ((R-Car Gen 3 H3)
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (6):
>       arm64: dts: r8a7795: Add missing blank lines between cpu nodes
>       clk: renesas: Add r8a7796 CPG Core Clock Definitions

This is just applied here as a patch, but will be needed on the clk
driver side too.

The patch should be shared between the two trees, not applied twice. So you'll
need to provide a stable branch from either side that has this applied, and
base the dts changes and the clk changes on that.

(Pull request not merged due to this).


-Olof
