From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Mar 2014 11:10:10 +0100
Subject: [PATCH] irqchip: sun4i: Fix acomment about mask register
 initialization
In-Reply-To: <1394553273-30473-1-git-send-email-hdegoede@redhat.com>
References: <1394553273-30473-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140312101010.GZ2815@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 04:54:33PM +0100, Hans de Goede wrote:
> The comment was claiming that we were masking all irqs, while the code actually
> *un*masks all of them.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/d2a72d11/attachment-0001.sig>
