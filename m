From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Jun 2017 14:08:17 +0200
Subject: [PATCH] pinctrl: sunxi: constify irq_domain_ops
In-Reply-To: <20170602112958.3882-1-tklauser@distanz.ch>
References: <20170602112958.3882-1-tklauser@distanz.ch>
Message-ID: <20170602120817.cekrag2imtbcnbqk@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 01:29:58PM +0200, Tobias Klauser wrote:
> struct irq_domain_ops is not modified, so it can be made const.
> 
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170602/34c22eb3/attachment.sig>
