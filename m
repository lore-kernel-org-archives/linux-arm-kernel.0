From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Sep 2015 21:38:44 +0200
Subject: [PATCH 2/3] ARM: dts: sun5i: Add sun5i-q8-common.dtsi
In-Reply-To: <1441464953-26351-2-git-send-email-hdegoede@redhat.com>
References: <1441464953-26351-1-git-send-email-hdegoede@redhat.com>
 <1441464953-26351-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150918193844.GV4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 05, 2015 at 04:55:52PM +0200, Hans de Goede wrote:
> This is the sun5i / a13 version of sun8i-q8-common.dtsi for use in dts
> files for a13 q8 based tablets. Compared to sun8i this uses uart1 for the
> serial console, and PG0 for card-detect for mmc0.
> 
> This also adds pmic and otg support, which both use the same config on
> all known q8 a13 devices. This is not present in sun5i-q8-common.dtsi
> because pmic / otg support for sun8i has not yet been merged.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/4c6e6f70/attachment.sig>
