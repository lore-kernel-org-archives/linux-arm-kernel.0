From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 00:28:20 +0100
Subject: [PATCH] ARM: Migrate to asm-generic wrapper support
In-Reply-To: <1311204225-13169-1-git-send-email-sboyd@codeaurora.org>
References: <1311204225-13169-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20110720232819.GC20310@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 04:23:45PM -0700, Stephen Boyd wrote:
> With d8ecc5c (kbuild: asm-generic support, 2011-04-27) we can
> remove a handful of asm-generic wrappers in ARM code.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> ---
> 
> I've specifically left out topology.h as it looks like that will not
> be generic much longer.

You don't mention in the commit log about the change to SZ_48M.
