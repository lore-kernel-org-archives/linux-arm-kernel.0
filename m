From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 26 Feb 2018 12:15:47 +0100
Subject: [v2,03/10] drm/sun4i: Protect the TCON pixel clocks
In-Reply-To: <7ed0fad9-6b3d-aafc-08a6-fb18761897aa@micronovasrl.com>
References: <d5224d2e81ecf73dc09f234e580ada52c00eaee3.1519204731.git-series.maxime.ripard@bootlin.com>
 <7ed0fad9-6b3d-aafc-08a6-fb18761897aa@micronovasrl.com>
Message-ID: <20180226111547.adm6cfvccceipgqh@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 24, 2018 at 12:31:36AM +0100, Giulio Benetti wrote:
> Il 21/02/2018 10:20, Maxime Ripard ha scritto:
> > From: Maxime Ripard <maxime.ripard@free-electrons.com>
> > 
> > Both TCON clocks are very sensitive to clock changes, since any change
> > might lead to improper timings.
> > 
> > Make sure our rate is never changed.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Tested-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Tested on A20-LiNova1-4_3i-ctp with Mali r6p2 installed.
> Before Mali changed dotclock, now it doesn't anymore.

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/d5b769b8/attachment-0001.sig>
