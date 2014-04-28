From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 28 Apr 2014 09:52:30 +0300
Subject: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
In-Reply-To: <20140425153150.GA20807@atomide.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com>
 <535A42D6.5090107@ti.com> <535A4470.2000509@ti.com> <535A5C0A.7040808@ti.com>
 <535A6C40.10609@ti.com> <20140425153150.GA20807@atomide.com>
Message-ID: <535DFAAE.1010606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/14 18:31, Tony Lindgren wrote:

> Chances are any mux register in the syscon area already works with
> pinctrl-single,pins or pinctrl-single,bits option. The ones in the
> padconf area should be already mapped so the driver just has to
> request them.

If using the padconf (say omap4_padconf_global for omap4), doesn't that
mean we need to have platform specific bits in the driver? Isn't that
something we've been trying to remove all the time?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/4bea3d89/attachment.sig>
