From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 2 Feb 2018 09:54:42 +0100
Subject: [PATCH 1/2] ARM: dts: sunxi: Switch MMC nodes away from
 cd-inverted property
In-Reply-To: <1517498160.5907.6.camel@tuxera.com>
References: <20171222205738.2389-1-tuomas@tuxera.com>
 <20180104150352.rsvtvviafxyuq2jp@flea.lan>
 <1517498160.5907.6.camel@tuxera.com>
Message-ID: <20180202085442.adhkkuymltlw5r2t@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 01, 2018 at 05:16:00PM +0200, Tuomas Tynkkynen wrote:
> Hi Maxime,
> 
> On Thu, 2018-01-04 at 16:03 +0100, Maxime Ripard wrote:
> > On Fri, Dec 22, 2017 at 10:57:37PM +0200, Tuomas Tynkkynen wrote:
> > > Using the cd-inverted property is not useful when GPIOs are used as
> > > card
> > > detects since the polarity can be specified with the usual
> > > GPIO_ACTIVE_(HIGH|LOW) GPIO flags. It has also caused confusion for
> > > U-Boot developers, so migrate all sunxi boards away from cd-
> > > inverted.
> > > 
> > > Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
> > 
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> I was assuming these patches will go in through the sunxi tree but I
> don't see them applied anywhere, have these patches fallen through the
> cracks perhaps?

It did, sorry.

I queued both for 4.17, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180202/89e6bdd6/attachment.sig>
