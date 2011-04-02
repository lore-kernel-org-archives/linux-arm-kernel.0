From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Apr 2011 10:19:04 +0100
Subject: [PATCH] ARM: Suspend: Fix build error on ARCH_S5PC100
In-Reply-To: <1301710155-16373-1-git-send-email-kgene.kim@samsung.com>
References: <1301710155-16373-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110402091904.GH8482@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 02, 2011 at 11:09:15AM +0900, Kukjin Kim wrote:
> The current mainline codes of ARCH_S5PC100 can not support
> suspend to ram. So needs this for preventing build error.
> 
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> Oops, I missed this in my previous patch.
> 
> As I know, firstly ARCH_S5P64X0 will support suspend to ram
> then ARCH_S5PC100 will do it. But right now, we need this.

I'd much rather do this a different way - let me know if this means
the SoC based dependencies can be dropped.  Patches to follow.
