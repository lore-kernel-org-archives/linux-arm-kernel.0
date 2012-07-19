From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Jul 2012 12:55:20 +0000
Subject: [PATCH 1/1] Add Wondermedia Technologies (wmt) to
 docs/devicetree/vendor-bindings.txt
In-Reply-To: <76F764B079F92A4E843589C893D0A022C3812054@SERVER.prisktech.co.nz>
References: <76F764B079F92A4E843589C893D0A022C380F1D4@SERVER.prisktech.co.nz>
 <201207191228.48809.arnd@arndb.de>
 <76F764B079F92A4E843589C893D0A022C3812054@SERVER.prisktech.co.nz>
Message-ID: <201207191255.20366.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 July 2012, Tony Prisk wrote:
> Which brings us back to the original question (and raises another one) - can we assume yet that
> 'wmt' will be the vendor-binding for Wondermedia? Also, what are we going to use for VIA-based
> SoC's given that VIA is the ticker for VIACOM. 
> 
> I did do a bit of a search on some stock tickers - 'WM' is Waste Management Inc. on the NYSE.
> Presumably this would be as safe, or safer, than WMT (Walmart).
> VIACOM, being a media content company, seems unlikely to produce any hardware but its possible
> they will rebrand others hardware.

"wm" has the danger of being confused with Wolfson Microelectronics, but
they are already listed in the documentation as using "wlf".

I'd really like to hear other opions from people on the devicetree-discuss
list, but if nobody replies, I'd suggest we go with "via" and "wm".

	Arnd
