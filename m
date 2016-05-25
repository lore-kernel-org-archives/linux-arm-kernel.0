From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 May 2016 14:40:53 +0200
Subject: [PATCH 0/6] ARM: dts: sun5i: q8-common: Enable various peripherals
In-Reply-To: <abbb9686-bbc7-cfad-ec1d-e5f099ac124b@redhat.com>
References: <1463500571-28970-1-git-send-email-wens@csie.org>
 <abbb9686-bbc7-cfad-ec1d-e5f099ac124b@redhat.com>
Message-ID: <20160525124053.GG9232@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Wed, May 18, 2016 at 10:13:52AM +0200, Hans de Goede wrote:
> Hi Chen-Yu,
> 
> On 17-05-16 17:56, Chen-Yu Tsai wrote:
> >Hi everyone,
> >
> >This series enables more peripherals for Allwinner A13-based Q8 devices.
> >The peripherals include the WiFi, the PMIC's micro-usb power supply
> >(driver), audio codec (headphone and speaker), and full display support
> >with the new DRM KMS driver. The series is based on parts of Maxime's
> >"drm: Add Support for Passive RGB to VGA bridges" series, specifically
> >the clk and drm fixes, and common DTS bits.
> >
> >Hans, since you have a collection of q8 tablets, I'm hoping you could
> >test these bits and provide some feedback.
> 
> I've not run any tests, just looked at the patches, the stuff in
> patch 3 is already present in arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
> I put it there because I saw some .fex files which don't use ldo3 for wifi
> I'm fine with moving it to -common though, I believe that you're right
> that it makes more sense there, having it in 2 places is not really
> useful though.

I'm not quite sure what you mean, do you want Chen-Yu to send a second
version, or are you ok with this patch?

Thanks,
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160525/2d9b7f8e/attachment-0001.sig>
