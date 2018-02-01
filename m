From: tuomas@tuxera.com (Tuomas Tynkkynen)
Date: Thu, 1 Feb 2018 17:16:00 +0200
Subject: [PATCH 1/2] ARM: dts: sunxi: Switch MMC nodes away from
 cd-inverted property
In-Reply-To: <20180104150352.rsvtvviafxyuq2jp@flea.lan>
References: <20171222205738.2389-1-tuomas@tuxera.com>
 <20180104150352.rsvtvviafxyuq2jp@flea.lan>
Message-ID: <1517498160.5907.6.camel@tuxera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Thu, 2018-01-04 at 16:03 +0100, Maxime Ripard wrote:
> On Fri, Dec 22, 2017 at 10:57:37PM +0200, Tuomas Tynkkynen wrote:
> > Using the cd-inverted property is not useful when GPIOs are used as
> > card
> > detects since the polarity can be specified with the usual
> > GPIO_ACTIVE_(HIGH|LOW) GPIO flags. It has also caused confusion for
> > U-Boot developers, so migrate all sunxi boards away from cd-
> > inverted.
> > 
> > Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I was assuming these patches will go in through the sunxi tree but I
don't see them applied anywhere, have these patches fallen through the
cracks perhaps?
