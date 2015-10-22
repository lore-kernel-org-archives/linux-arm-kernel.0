From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Oct 2015 10:58:24 +0200
Subject: [PATCH v2] ARM: dts: sun4i: Add dts file for the pov
 protab2-ips9 tablet
In-Reply-To: <1445378669-21622-1-git-send-email-hdegoede@redhat.com>
References: <1445378669-21622-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20151022085824.GU10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 12:04:29AM +0200, Hans de Goede wrote:
> The Point of View protab2-ips9 is a tablet with a 9" ips 1024x768 lcd screen,
> microsd slot, headphones, mini hdmi, mini usb b and power barrel connectors.
> 
> It uses a rtl8188cus usb wifi chip and a RDA 5875Y bluetooth chip attached
> to uart2. It has a bma250 accelerometer attached to i2c1 addr 0x18, this
> only works when ldo3 is set to 2.8 volt, otherwise i2c1 gets stuck, so
> for now we mark i2c1 as failed.
> 
> It has a pixcir,pixcir_tangoc compatible touchscreen attached to i2c2 addr
> 0x5c. This is not enabled in this dts, because this variant of the
> pixcir_tangoc has separate wakeup and enable pins both of which need
> to be driven low before the touchscreen will work. Before we can enable
> this the pixcir driver and devicetree-bindings need to be extended to
> support these pins.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151022/f81af65f/attachment-0001.sig>
