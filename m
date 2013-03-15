From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Mar 2013 09:28:38 -0700
Subject: [PATCH] [media] ir: IR_RX51 only works on OMAP2
In-Reply-To: <20130315063913.GC1638@itanic.dhcp.inet.fi>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
 <1363298204-8014-7-git-send-email-arnd@arndb.de>
 <20130315063913.GC1638@itanic.dhcp.inet.fi>
Message-ID: <20130315162837.GD9370@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Timo Kokkonen <timo.t.kokkonen@iki.fi> [130314 23:43]:
> On 03.14 2013 22:56:44, Arnd Bergmann wrote:
> > This driver can be enabled on OMAP1 at the moment, which breaks
> > allyesconfig for that platform. Let's mark it OMAP2PLUS-only
> > in Kconfig, since that is the only thing it builds on.
> > 
> 
> Acked-by: Timo Kokkonen <timo.t.kokkonen@iki.fi>

Acked-by: Tony Lindgren <tony@atomide.com>
