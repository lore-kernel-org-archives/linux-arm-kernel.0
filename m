From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Sep 2015 18:43:21 +0200
Subject: [PATCH 3/3] ARM: dts: sun4i: Add dts file for iNet-1 based tablets
In-Reply-To: <1441787004-4660-3-git-send-email-hdegoede@redhat.com>
References: <1441787004-4660-1-git-send-email-hdegoede@redhat.com>
 <1441787004-4660-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150910164321.GL9885@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2015 at 10:23:24AM +0200, Hans de Goede wrote:
> The iNet-tek iNet-1 PCB is a PCB found in various generic 10.1" 1024x600
> A10 based tablets such as the Point of View Protab2 XXL and the
> Cherry M1007.
> 
> This patch has been tested on both rev2 and rev5 of this board / these
> tablets.
> 
> It comes with a rtl8188cus usb wifi connected to ehci1, focal ft5406ee8
> touchscreen connected to i2c2 addr 0x38, bosch bma 250 accelerometer
> connected to i2c1 addr 0x18 and the usual connectors: headphone,
> mini hdmi, power-barrel, mini-usb and a micro-sd slot.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150910/17c44469/attachment-0001.sig>
