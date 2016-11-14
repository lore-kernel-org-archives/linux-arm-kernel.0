From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Nov 2016 21:08:20 +0100
Subject: [PATCH 2/2] ARM: dts: sun8i: reference-design-tablet: ldo_io1 is
 vcc-touchscreen
In-Reply-To: <20161113192203.7101-2-hdegoede@redhat.com>
References: <20161113192203.7101-1-hdegoede@redhat.com>
 <20161113192203.7101-2-hdegoede@redhat.com>
Message-ID: <20161114200820.xd2yoo6gfxgnegld@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 13, 2016 at 08:22:03PM +0100, Hans de Goede wrote:
> On some Q8 and other tablets ldo_io1 is used as vcc-touchscreen,
> config at as such in sun8i-reference-design-tablet.dtsi.
> 
> Note that it will only be enabled when it us actually referenced by
> a foo-supply property in the touchscreen node, so for tablets which
> do not use ldo_io1 as vcc-touchscreen, it will be disabled.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/4197396f/attachment.sig>
