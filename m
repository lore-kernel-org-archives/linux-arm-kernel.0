From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 7 Dec 2013 20:40:49 -0500
Subject: [PATCH] mtd: nand: pxa3xx: Disable "armada370-nand" compatible
 support
In-Reply-To: <20131208013525.GA4487@localhost>
References: <1386430787-2962-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131207232315.GC11251@titan.lakedaemon.net>
 <20131208013525.GA4487@localhost>
Message-ID: <20131208014049.GJ11251@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 07, 2013 at 10:35:26PM -0300, Ezequiel Garcia wrote:
> If we agree to remove the lines, shall we also revert the binding
> documentation, removing the compatible from there as well?

I think this is unnecessary.  We're trying to prevent breaking
bisection.  No one in their right mind should be developing (and
referring to docs) at a random commit.  As long as the docs are correct,
leave them alone.

thx,

Jason.
