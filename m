From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Nov 2014 17:47:49 +0100
Subject: [PATCH 6/7] ARM: dts: sun6i: Add EHCI support for the M9 board
In-Reply-To: <1415871109-28332-6-git-send-email-hdegoede@redhat.com>
References: <1415871109-28332-1-git-send-email-hdegoede@redhat.com>
 <1415871109-28332-6-git-send-email-hdegoede@redhat.com>
Message-ID: <20141113164749.GN20972@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 10:31:48AM +0100, Hans de Goede wrote:
> The Mele M9 / A1000G quad uses both usb-ports, one goes to an internal
> usb wifi card, the other to a build-in usb-hub, so neither need their
> OHCI companion controller to be enabled since the are always connected at
> USB-2 speeds.
> 
> The controller which is attached to the wifi also does not need a vbus
> regulator.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, with a newline before the pinctrl node.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/4e452451/attachment-0001.sig>
