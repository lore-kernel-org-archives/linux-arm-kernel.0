From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Sep 2015 16:31:24 +0200
Subject: [PATCH 1/3] ARM: dts: sunxi: Add sun?i-q8-common.dtsi files for
 q8 tablets
In-Reply-To: <1441464953-26351-1-git-send-email-hdegoede@redhat.com>
References: <1441464953-26351-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150908143124.GA31584@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 05, 2015 at 04:55:51PM +0200, Hans de Goede wrote:
> Cheap allwinner based devices in the q8 enclosure come in many variants,
> all sharing the case and a number of other basic features.
> 
> They differ in the display, touchscreen, accelerometer and wifi chips
> used.
> 
> This commit adds 2 dtsi files defining the shared features of all the
> q8 tablets. sunxi-q8-common.dtsi defines features shared amongst all
> q8 tablets, sun8i-q8-common.dtsi defines features shared amongst all
> a23 / a33 based q8 tablets, but not with a13 q8 based tablets.
> 
> a13 based tablets use a different card-detect pin for the mmc, and
> use uart1 instead of the r_uart for the serial console.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150908/8565a8e4/attachment.sig>
