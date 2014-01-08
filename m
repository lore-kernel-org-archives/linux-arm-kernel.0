From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Jan 2014 14:02:21 +0100
Subject: [ANNOUNCE] sunxi-babelfish (FEX-to-DT translator)
In-Reply-To: <20140107220310.GD3103@lukather>
References: <20140107220310.GD3103@lukather>
Message-ID: <201401081402.22036.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 January 2014, Maxime Ripard wrote:

> Anyway, enough talking. Any feedback is, as usual, appreciated.

I think it's a pretty cool idea. Have you considered integrating this with
the impedence-matcher project at

https://github.com/zonque/pxa-impedance-matcher ?

That one basically does the same thing for atags-based boot loaders and I
would guess that parts of the implementation can be shared as well, plus
the combination could support a wider range of devices.

	Arnd
