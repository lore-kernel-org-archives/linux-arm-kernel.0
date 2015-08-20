From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Aug 2015 08:45:45 +0200
Subject: [PATCH 4/6] ARM: dts: sun7i: Enable USB DRC on pcDuino 3
In-Reply-To: <1439563477-12295-5-git-send-email-hdegoede@redhat.com>
References: <1439563477-12295-1-git-send-email-hdegoede@redhat.com>
 <1439563477-12295-5-git-send-email-hdegoede@redhat.com>
Message-ID: <20150820064545.GM30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 04:44:35PM +0200, Hans de Goede wrote:
> From: Jelle van der Waa <jelle@vdwaa.nl>
> 
> Enable the otg/drc usb controller on the pcDuino 3.
> 
> Note this board has the otg-vbus connected directly to the 5v-dcc of
> the board, so there is no vbus0 regulator, nor vbus0-det.

Can it do OTG then? If VBUS is tied to the 5v, there's no way for the
board to shut it down when acting as peripheral, right?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/b32cc8e0/attachment-0001.sig>
