From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 18:58:24 +0200
Subject: [PATCH v2 3/3] ARM: dts: sun8i: Enable USB DRC on Ippo Q8H-A33
 tablet
In-Reply-To: <1438347218-8158-3-git-send-email-hdegoede@redhat.com>
References: <1438347218-8158-1-git-send-email-hdegoede@redhat.com>
 <1438347218-8158-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150731165824.GJ2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 02:53:38PM +0200, Hans de Goede wrote:
> Enable the otg/drc usb controller on the Ippo Q8H-A33 tablet, for now it
> is enabled in host-only mode, because true OTG support requires support
> for detecting and enabling Vbus through the axp221 pmic.
> 
> For this to work the Vbus on the port must be enabled by u-boot,
> or a powered hub must be used.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/1605ac37/attachment.sig>
