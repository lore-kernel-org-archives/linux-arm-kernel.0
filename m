From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Mar 2012 10:41:34 -0800
Subject: [PATCH] ARM: tegra: match SoC name not board name in DT board
 files
In-Reply-To: <1330392376-7884-1-git-send-email-swarren@nvidia.com>
References: <1330392376-7884-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120304184134.GF31064@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 06:26:16PM -0700, Stephen Warren wrote:
> board-dt-tegra*.c should support any board using Tegra when booted using
> device tree. Instead of explicitly listing all the supported boards,
> which requires a kernel change for each new board, list the supported SoC
> model instead.
> 
> Note that the board files do currently have explicit support for setting
> up each board's pinmux. However, it's fairly likely that at least the
> basic devices on any new board will work just fine as set up by the boot-
> loader, and the pinmux data should be moving into device tree soon anyway.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied.


-Olof
