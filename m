From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Jun 2013 12:34:35 +0200
Subject: [PATCH 4/6] ARM: sunxi: dt: Add Allwinner A10s DTSI
In-Reply-To: <3346364.JR9UrJYqP8@wuerfel>
References: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
 <1370795767-9769-5-git-send-email-maxime.ripard@free-electrons.com>
 <3346364.JR9UrJYqP8@wuerfel>
Message-ID: <20130610103435.GJ2748@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Sun, Jun 09, 2013 at 11:36:24PM +0200, Arnd Bergmann wrote:
> On Sunday 09 June 2013 18:36:05 Maxime Ripard wrote:
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun5i-a10s.dtsi | 286 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 286 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun5i-a10s.dtsi
> 
> Would it make sense to split out the parts that are common with A13 into
> a separate sun5i.dtsi file?

I don't have the documentation at the moment, so I'm not exactly sure at
which extent it's similar to the A13. Yet for the moment, the two dtsi
are very different (different clock definitions, different muxings,
etc.), so , I'm not quite sure about wether it would make stuff smaller.

Of course, if we find they actually share a lot, we can definitely make
a common sun5i DTSI later.

But if you prefer to have it right now, I can always send a v2 :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
