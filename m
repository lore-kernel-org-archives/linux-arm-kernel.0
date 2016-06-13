From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Jun 2016 10:18:13 +0200
Subject: [PATCH v3 1/2] ARM: dts: sun6i: Add pmic / regulator nodes to
 Mele A1000G quad dts
In-Reply-To: <1465729621-27378-1-git-send-email-hdegoede@redhat.com>
References: <1465729621-27378-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160613081813.GD4481@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 01:07:00PM +0200, Hans de Goede wrote:
> Add pmic / regulator nodes to Mele A1000G quad dts.
> 
> Note both reg_usb1_vbus and reg_dldo4 need to be on for the hub attached
> to usb1 to work, and we can list only one usb1_vbus-supply, so dldo4 is
> marked as regulator-always-on.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied both, thanks!
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/468ecfda/attachment.sig>
