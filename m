From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Mar 2015 18:21:57 +0100
Subject: [PATCH 4/7] ARM: dts: sun5i: Add new Auxtek-t004 board
In-Reply-To: <1425754884-7875-4-git-send-email-hdegoede@redhat.com>
References: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
 <1425754884-7875-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20150308172157.GE5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 07, 2015 at 08:01:21PM +0100, Hans de Goede wrote:
> The auxtek-t004:
> http://www.fasttech.com/products/1110/10004200/1318603-auxtek-t004-allwinner-a10s-single-core-android-ics
> 
> Is an Allwinner A10s based hdmi tv stick with with 512M RAM, 4G nand flash,
> toc9002 (bcm43362) sdio wifi, 1 USB host ports using an USB-A receptacle and
> a 2 micro-usb receptacles, one for power and one for USB OTG.
> 
> The sdio wifi appears to not have an oob irq hooked up, so we rely on sdio-irq
> support for it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> foo

I'm not sure what that foo was about :)

I removed it, and applied the patch, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150308/8a2bc2d5/attachment.sig>
