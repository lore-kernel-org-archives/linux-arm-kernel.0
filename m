From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Nov 2016 21:24:49 +0100
Subject: [PATCH v2] ARM: dts: sun5i: Add touchscreen node to
 reference-design-tablet.dtsi
In-Reply-To: <20161116131508.12541-1-hdegoede@redhat.com>
References: <20161116131508.12541-1-hdegoede@redhat.com>
Message-ID: <20161117202449.hgn5ws4l3nowx563@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 02:15:08PM +0100, Hans de Goede wrote:
> Just like on sun8i all sun5i tablets use the same interrupt and power
> gpios for their touchscreens. I've checked all known a13 fex files and
> only the UTOO P66 uses a different gpio for the interrupt.
> 
> Add a touchscreen node to sun5i-reference-design-tablet.dtsi, which
> fills in the necessary gpios to avoid duplication in the tablet dts files,
> just like we do in sun8i-reference-design-tablet.dtsi.
> 
> This will make future patches adding touchscreen nodes to a13 tablets
> simpler.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161117/173b0eaf/attachment.sig>
