From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Feb 2014 09:05:38 +0100
Subject: [PATCH 4/4] pinctrl-sunxi: Fix interrupt register offset
 calculation
In-Reply-To: <1392671984-29872-5-git-send-email-hdegoede@redhat.com>
References: <1392671984-29872-1-git-send-email-hdegoede@redhat.com>
 <1392671984-29872-5-git-send-email-hdegoede@redhat.com>
Message-ID: <20140218080538.GC3142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 10:19:44PM +0100, Hans de Goede wrote:
> This fixing setting the interrupt type for eints >= 8.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/f4608c70/attachment.sig>
