From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Dec 2011 20:28:40 +0000
Subject: [PATCH] arm/imx6: add restart support for imx6q
In-Reply-To: <1322668872-13011-1-git-send-email-shawn.guo@linaro.org>
References: <1322668872-13011-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111201202840.GF9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 12:01:12AM +0800, Shawn Guo wrote:
> This patch is to support restart support for imx6q based on your
> 'reset' branch.  Is it possible for you to take this patch through
> your 'reset' branch?

I'm willing to append to the 'restart' branch any patch which improves
the restart handling for any ARM platform.

The only thing I request is that - at the moment - they come as patches
rather than a git pull, as I'm still trying to chase maintainers to get
their stuff fixed for these changes next merge window.  I'll also be
applying any such patches immediately after the commit:

	"ARM: restart: remove the now empty arch_reset()"

which is the current head of the 'restart' branch.  What follows that
commit is the 'junk' changes (which are either broken or incomplete)
which won't be sent upstream.

The 'reset' branch is everything including the junk stuff.
