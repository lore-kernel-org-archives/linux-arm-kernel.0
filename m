From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 15 Jun 2017 10:20:53 +0200
Subject: [PATCH] arm64: dts: marvell: enable the cpm crypto engine on the
 mcbin
In-Reply-To: <87zid97jk1.fsf@free-electrons.com>
References: <20170615080150.27534-1-antoine.tenart@free-electrons.com>
 <87zid97jk1.fsf@free-electrons.com>
Message-ID: <20170615082053.GC4773@kwain.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Thu, Jun 15, 2017 at 10:15:58AM +0200, Gregory CLEMENT wrote:
>  On jeu., juin 15 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:
> 
> > This patch enables the cpm crypto engine on the mcbin.
> 
> as this controller is always present and dot not depend on any
> pinmux configuration, could you enable it at SoC level?

That's right. I'll send a new version enabling this at SoC level (and
cleaning up dts files that already enable it).

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170615/c0dd4898/attachment.sig>
