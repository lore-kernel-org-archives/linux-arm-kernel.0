From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Sep 2015 21:41:03 +0200
Subject: [PATCH 3/3] ARM: dts: sun5i: Add dts file for q8 formfactor a13
 based tablets
In-Reply-To: <1441464953-26351-3-git-send-email-hdegoede@redhat.com>
References: <1441464953-26351-1-git-send-email-hdegoede@redhat.com>
 <1441464953-26351-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150918194103.GW4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 05, 2015 at 04:55:53PM +0200, Hans de Goede wrote:
> This commits adds a generic dts file for q8 formfactor a13 based tablets.
> 
> The tablets ship in many variants, with the difference mainly being the
> touchscreen controller / accelerometer / wifi chip used.
> 
> The wifi is USB based, and thus not listed in devicetree.
> 
> The touchscreen controller / accelerometer may turn out to be a problem
> once we add support for those. We can either do something with devicetree
> overlays, or add sun5i-a13-<touchscreen>-<accelerometer>.dts files. The
> latter is what the android mod community is doing with firmware images.
> 
> This dts was tested with an a13 q8 tablet with a pcb labelled: "94V-0",
> silead gsl1680 touchscreen controller and a mc32x0 accelerometer.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Fixed the conflicts and applied. Please post the patches on top of the
current sunxi/for-next branch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/65c184bd/attachment.sig>
