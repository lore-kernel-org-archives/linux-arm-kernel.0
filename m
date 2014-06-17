From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jun 2014 22:34:30 +0200
Subject: [PATCH v2 2/4] pinctrl: sunxi: Move setting of mux to irq type
 from unmask to request_resources
In-Reply-To: <1402691764-17562-3-git-send-email-hdegoede@redhat.com>
References: <1402691764-17562-1-git-send-email-hdegoede@redhat.com>
 <1402691764-17562-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20140617203430.GC19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 10:36:02PM +0200, Hans de Goede wrote:
> With level triggered interrupt mask / unmask will get called for each
> interrupt, doing the somewhat expensive mux setting on each unmask thus is
> not a good idea. Instead add a request_resources callback and do it there.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/3d3df746/attachment.sig>
