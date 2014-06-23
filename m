From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 23 Jun 2014 08:21:00 -0400
Subject: linux-next: manual merge of the mvebu tree with Linus' tree
In-Reply-To: <20140623105741.70094961@canb.auug.org.au>
References: <20140623105741.70094961@canb.auug.org.au>
Message-ID: <20140623122100.GK21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 10:57:41AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mvebu tree got a conflict in
> arch/arm/mach-mvebu/Kconfig between commit 21278aeafbfa ("ARM: use
> menuconfig for sub-arch menus") from Linus' tree and commit
> 55fc83023212 ("ARM: Kirkwood: Add setup file for netxbig LEDs") from
> the mvebu tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Looks good.  Thanks Stephen.

thx,

Jason.
