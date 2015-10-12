From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Oct 2015 15:49:50 +0200
Subject: [PATCH] pwm: sun4i: Add support for pwm controller on sun5i SoCs
In-Reply-To: <1444556997-28885-1-git-send-email-hdegoede@redhat.com>
References: <1444556997-28885-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20151012134950.GC2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 11, 2015 at 11:49:57AM +0200, Hans de Goede wrote:
> The pwm controller on sun5i SoCs is identical to the one found on sun7i
> SoCs. On the A13 package only one of the 2 pins is routed to the outside,
> so only advertise one pwm there.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/394d5cef/attachment.sig>
