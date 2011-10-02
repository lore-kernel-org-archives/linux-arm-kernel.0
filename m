From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Oct 2011 20:18:48 +0100
Subject: [PATCH 21/30] sound/soc/omap: limit to omap2plus
In-Reply-To: <1317566760-25681-22-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-22-git-send-email-arnd@arndb.de>
Message-ID: <20111002191847.GA1005@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 04:45:51PM +0200, Arnd Bergmann wrote:
> These drivers do not build correctly on omap1, so only allow
> selecting them on omap2 or higher.

No, OMAP1 is supposed to work and people actively seem to care about it.
If there's some problem with OMAP1 then please report it so that it can
be fixed.

You should also *always* both CC maintainers and relevant mailing lists
on patches so they can see what's going on (I'm being especially grumpy
now because you really should know better), and my previous comments
about subject lines also apply.
