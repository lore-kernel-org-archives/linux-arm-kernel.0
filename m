From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 May 2017 19:05:16 +0200
Subject: [PATCH] clk: sunxi-ng: explicitly include linux/spinlock.h
In-Reply-To: <20170515102307.28743-1-tklauser@distanz.ch>
References: <20170515102307.28743-1-tklauser@distanz.ch>
Message-ID: <20170516170516.d6uvqzhuswj7skjj@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 12:23:07PM +0200, Tobias Klauser wrote:
> ccu_reset.h and ccu_reset.c use spinlock_t and associated functions but
> rely on implict inclusion of linux/spinlock.h which means that changes
> in other headers could break the build. Thus, add an explicit include.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170516/c99cefe1/attachment.sig>
