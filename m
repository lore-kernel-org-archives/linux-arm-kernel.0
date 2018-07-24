From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 14:37:41 +0200
Subject: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
In-Reply-To: <2309112.TTVI9Fv1ar@jernej-laptop>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
 <20180711083036.7attjq4hm5ay5gmn@flea>
 <2309112.TTVI9Fv1ar@jernej-laptop>
Message-ID: <20180724123741.bbkjgy2uwmzsj45k@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2018 at 04:43:56PM +0200, Jernej ?krabec wrote:
> Hi Maxime,
> 
> Dne sreda, 11. julij 2018 ob 10:30:36 CEST je Maxime Ripard napisal(a):
> > On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
> > > This series fixes several issues found in R40 HDMI patch series after
> > > it was applied. Conversation can be found here:
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011.htm
> > > l
> > > 
> > > Patches are based on latest linux-next (next-20180710) and are ordered
> > > in such way that they don't break R40 HDMI at any time. Because of that
> > > I suggest that whole series goes through drm-misc to preserve that order.
> > > 
> > > I also tested those patches on H3 to make sure it doesn't break other
> > > platforms. However, it would be nice to test for regressions also on
> > > older SoCs (with DE1).
> > > 
> > > Best regards,
> > > Jernej
> > 
> > Applied all patches but the patch 10, thanks!
> > Maxime
> 
> It seems that you forgot to merge some patches:
> 
> [PATCH v2 12/18] drm/sun4i: tcon: Add another way for matching mixers with 
> tcon
> [PATCH v2 13/18] drm/sun4i: tcon: Add support for R40 TCON
> 
> Without them, R40 display pipeline can't work.
> 
> Maybe they are in your spam folder?

Thanks for telling me, I'm not quite sure what happened.

I've applied them.

Sorry,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/a475a106/attachment.sig>
