From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 11 Jun 2016 17:46:44 +0200
Subject: [PATCH v2 1/2] ARM: dts: sun6i: Add pmic / regulator nodes to
 Mele A1000G quad dts
In-Reply-To: <1465469898-8102-1-git-send-email-hdegoede@redhat.com>
References: <1465469898-8102-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160611154644.GF19854@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 12:58:17PM +0200, Hans de Goede wrote:
> Add pmic / regulator nodes to Mele A1000G quad dts.
> 
> Note both reg_usb1_vbus and reg_dldo4 need to be on for the hub attached
> to usb1 to work, and we can list only one usb1_vbus-supply, so dldo4 is
> marked as regulator-always-on.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Add a bit to the commit msg explaining why dldo4 is marked regulator-always-on

We should really have that as a comment in the DT.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160611/2ecc5757/attachment.sig>
