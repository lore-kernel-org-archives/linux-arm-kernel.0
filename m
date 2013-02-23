From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 23 Feb 2013 22:31:45 +0000
Subject: [patch 2/2] arm: Wire up kcmp syscall
In-Reply-To: <20130219070703.GC20312@moon>
References: <20130219064800.719149796@openvz.org>
 <20130219065210.148067470@openvz.org> <20130219070703.GC20312@moon>
Message-ID: <201302232231.45972.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 February 2013, Cyrill Gorcunov wrote:
> From: Alexander Kartashov <alekskartashov@parallels.com>
> Subject: arm: Wire up kcmp syscall
> 
> Signed-off-by: Alexander Kartashov <alekskartashov@parallels.com>
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Looks uncontroversial since the number is already reserved and
there is a cond_syscall() line, which means it does not
even depend on patch 1.

Russell, are you picking this one up?
