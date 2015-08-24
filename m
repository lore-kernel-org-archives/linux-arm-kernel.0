From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Aug 2015 15:35:18 +0200
Subject: [PATCH 1/5] ARM: dts: sun4i: inet97fv2: Disable unused usb
 controllers
In-Reply-To: <1440369446-22195-1-git-send-email-hdegoede@redhat.com>
References: <1440369446-22195-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150824133518.GL2413@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 12:37:22AM +0200, Hans de Goede wrote:
> The inet97fv2 tablet only has a usb-2 wifi device connected to the second
> ehci controller, disable the first ehci controller and both ohci
> controllers.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued, thanks.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150824/c7703755/attachment-0001.sig>
