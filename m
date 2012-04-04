From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Apr 2012 12:14:35 -0700
Subject: [PATCH 11/11] ARM: dt: tegra20: add pinmux to device tree
In-Reply-To: <1333148404-17691-12-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-12-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120404191435.GC10603@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 05:00:04PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This adds a complete pinmux configuration to all Tegra20 device tree
> files. This allows removal of board-dt-tegra20.c's use of the pinmux
> board files, and the special device tree handling in board-pinmux.c.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Olof Johansson <olof@lixom.net>

It would be nice to do a more compact representation in the device tree, but
this buys us enough that I'm quite happy with the way it turned out anyway.

Once we have some sort of preprocessor support maybe. :-)


-Olof
