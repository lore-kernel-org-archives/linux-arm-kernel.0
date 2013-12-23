From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Dec 2013 14:36:02 -0600
Subject: [PATCH v8 9/9] ARM: dts: add usb udc support to bcm281xx
In-Reply-To: <1387462990-12039-10-git-send-email-mporter@linaro.org>
References: <1387462990-12039-1-git-send-email-mporter@linaro.org>
 <1387462990-12039-10-git-send-email-mporter@linaro.org>
Message-ID: <20131223203602.GC15101@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 09:23:10AM -0500, Matt Porter wrote:
> Adds USB OTG/PHY and clock support to BCM281xx and enables
> UDC support on the bcm11351-brt and bcm28155-ap boards.
> 
> Signed-off-by: Matt Porter <mporter@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>

doesn't apply to my tree:

checking file arch/arm/boot/dts/bcm11351-brt.dts
checking file arch/arm/boot/dts/bcm11351.dtsi
Hunk #1 FAILED at 243.
1 out of 1 hunk FAILED
checking file arch/arm/boot/dts/bcm28155-ap.dts

I will skip this patch from my tree, all others are now in my
testing/next branch after fixing dependency ARM-only for now.

Send me a patch removing ARCH dependency for v3.15, since this driver
can be used in other arches too.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131223/7f6f323f/attachment-0001.sig>
