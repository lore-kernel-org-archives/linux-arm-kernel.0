From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Mon, 18 Mar 2013 20:54:03 -0300
Subject: [PATCH] [media] ir: IR_RX51 only works on OMAP2
In-Reply-To: <1363298204-8014-7-git-send-email-arnd@arndb.de>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
 <1363298204-8014-7-git-send-email-arnd@arndb.de>
Message-ID: <20130318205403.4203e2fe@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Thu, 14 Mar 2013 22:56:44 +0100
Arnd Bergmann <arnd@arndb.de> escreveu:

> This driver can be enabled on OMAP1 at the moment, which breaks
> allyesconfig for that platform. Let's mark it OMAP2PLUS-only
> in Kconfig, since that is the only thing it builds on.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Cc: Timo Kokkonen <timo.t.kokkonen@iki.fi>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linux-media at vger.kernel.org
> ---
> Mauro, please apply for 3.9

OK, I'm applying it on my 3.9 branch right now.

Thanks!
Mauro
