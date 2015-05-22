From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 May 2015 13:20:09 +0100
Subject: [alsa-devel] [PATCH 10/13] sound/core: add DRM ELD helper
In-Reply-To: <E1Yr1xy-0006l8-Ft@rmk-PC.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1xy-0006l8-Ft@rmk-PC.arm.linux.org.uk>
Message-ID: <20150522122009.GK21391@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 09, 2015 at 11:26:42AM +0100, Russell King wrote:
> Add a helper for the EDID like data structure, which is typically passed
> from a HDMI adapter to its associated audio driver.  This informs the
> audio driver of the capabilities of the attached HDMI sink.

As far as I can tell people are fairly happy with the implementation
here and unless I'm missing something are definitely happy with the
interface.  If that's the case can we get this into -next?  There's a
lot of interest in HDMI right now (which is great) and this would be
helpful for that, it seems like even if there are issues with the
implementation it would be worth merging as is so we can start adding
users and then do any improvements to the interface in parallel.

>From an interface point of view:

Reviewed-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150522/d4c27752/attachment.sig>
