From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 12:50:31 +0000
Subject: [PATCH 1/1] Add Wondermedia Technologies (wmt) to
 docs/devicetree/vendor-bindings.txt
In-Reply-To: <76F764B079F92A4E843589C893D0A022C380F1D4@SERVER.prisktech.co.nz>
References: <76F764B079F92A4E843589C893D0A022C380F1D4@SERVER.prisktech.co.nz>
Message-ID: <201207171250.32265.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012, Tony Prisk wrote:
> From 756ae5c2f475d679649adff99058679b651af8d9 Mon Sep 17 00:00:00 2001
> From: Tony Prisk <linux@prisktech.co.nz>
> Date: Tue, 17 Jul 2012 19:09:31 +1200
> Subject: [PATCH] Add Wondermedia Technologies (wmt) to vendor-prefixes.txt
>  Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
 
Something went wrong with exporting the patch. You probably used git-show
rather than git-format-patch, so you got the wrong headers.

It would also be helpful to describe why the specific string is used here.
Normally we use the stock ticker symbol and "wmt" refers to Wal-Mart,
which would be unlikely but not impossible to produce their own hardware
in the future. The same thing applies to "via", which is VIACOM. The symbol
for VIA technologies is "2388.TW", but that is not particularly descriptive
or well-known.

Maybe someone on the devicetree-discuss mailing list has a better
suggestion. I think using "via" is probably the best compromise, as
it's a well-known name and most of the components of the wondermedia
chips were first made by VIA anyway.

	Arnd
