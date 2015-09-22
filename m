From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Sep 2015 16:44:01 +0200
Subject: [PATCH 4/5] ARM: dts: sun8i: Add pwm-backlight device for
 A23/A33 Q8 format tablets
In-Reply-To: <1442752251-20744-5-git-send-email-hdegoede@redhat.com>
References: <1442752251-20744-1-git-send-email-hdegoede@redhat.com>
 <1442752251-20744-5-git-send-email-hdegoede@redhat.com>
Message-ID: <20150922144401.GE4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 20, 2015 at 08:30:50AM -0400, Hans de Goede wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The LCD backlight on the A23/A33 Q8 format tablets is enabled
> with a GPIO controlled regulator, and brightness controlled with
> the SoC's PWM controller.
> 
> The backlight is powered from the AXP223 PMIC's DC1SW output,
> which is not supported yet. A proper bootloader is required
> to enable it.
> 
> The brightness levels are arbitrary. The FEX files do not have
> such information. As such, actual brightness levels may differ
> from device to device.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150922/44c0da5a/attachment.sig>
