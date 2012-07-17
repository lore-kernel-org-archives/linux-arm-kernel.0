From: alchark@gmail.com (Alexey Charkov)
Date: Tue, 17 Jul 2012 15:30:53 +0200
Subject: [PATCH 1/1] Add Wondermedia Technologies (wmt) to
 docs/devicetree/vendor-bindings.txt
In-Reply-To: <201207171250.32265.arnd@arndb.de>
References: <76F764B079F92A4E843589C893D0A022C380F1D4@SERVER.prisktech.co.nz>
 <201207171250.32265.arnd@arndb.de>
Message-ID: <CABjd4Yyk6XR6RizgcpjCdi2N_+Z2EzTtezbkN9V7r4bAXXjhqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/7/17 Arnd Bergmann <arnd@arndb.de>:
> It would also be helpful to describe why the specific string is used here.
> Normally we use the stock ticker symbol and "wmt" refers to Wal-Mart,
> which would be unlikely but not impossible to produce their own hardware
> in the future. The same thing applies to "via", which is VIACOM. The symbol
> for VIA technologies is "2388.TW", but that is not particularly descriptive
> or well-known.
>
> Maybe someone on the devicetree-discuss mailing list has a better
> suggestion. I think using "via" is probably the best compromise, as
> it's a well-known name and most of the components of the wondermedia
> chips were first made by VIA anyway.

In fact, "wmt" is the name that the vendor itself uses in their GPL
code (they also use mach-wmt as the arch-specific folder name). I
believe that we could just as well use the full "wondermedia" word to
avoid possible confusion, in case "wmt" is unacceptable for any
reason.

Best,
Alexey
