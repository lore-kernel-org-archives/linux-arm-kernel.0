From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Jun 2013 16:58:28 +0200
Subject: [PATCH 4/6] ARM: sunxi: dt: Add Allwinner A10s DTSI
In-Reply-To: <20130610103435.GJ2748@lukather>
References: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
 <3346364.JR9UrJYqP8@wuerfel> <20130610103435.GJ2748@lukather>
Message-ID: <201306101658.28353.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 June 2013, Maxime Ripard wrote:
> I don't have the documentation at the moment, so I'm not exactly sure at
> which extent it's similar to the A13. Yet for the moment, the two dtsi
> are very different (different clock definitions, different muxings,
> etc.), so , I'm not quite sure about wether it would make stuff smaller.
> 
> Of course, if we find they actually share a lot, we can definitely make
> a common sun5i DTSI later.
> 
> But if you prefer to have it right now, I can always send a v2 :)

I thought it was actually the same silicon in a different package with
fewer pins, but if the files look very different right now, just leave
them separately.

	Arnd
