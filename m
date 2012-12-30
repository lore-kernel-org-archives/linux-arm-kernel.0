From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Dec 2012 21:32:04 -0800
Subject: [PATCH 1/2] ARM: dts: prevent *.dtb from always being rebuilt
In-Reply-To: <1356741767-29292-1-git-send-email-swarren@wwwdotorg.org>
References: <1356741767-29292-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121230053204.GC20903@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 28, 2012 at 05:42:46PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> if_changed (used by the *.dts->*.dtc rule) rebuilds files if they aren't
> contained in $(targets). (make V=2 indicates this). Add $(dtb-y) to
> $(targets) to prevent *.dtb from always being rebuilt.
> 
> This fixes a regression introduced by the .dtb rule rework in 499cd82
> "ARM: dt: change .dtb build rules to build in dts directory".
> 
> Reported-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Not sure who you have in mind to apply this, but if it's not through arm-soc:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
