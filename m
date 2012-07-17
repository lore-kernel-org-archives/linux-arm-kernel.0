From: sentientnz@yahoo.co.nz (Tony Prisk)
Date: Tue, 17 Jul 2012 06:47:21 -0700 (PDT)
Subject: [PATCH 1/1] Add Wondermedia Technologies (wmt) to
 docs/devicetree/vendor-bindings.txt
In-Reply-To: <201207171250.32265.arnd@arndb.de>
References: <76F764B079F92A4E843589C893D0A022C380F1D4@SERVER.prisktech.co.nz>
 <201207171250.32265.arnd@arndb.de>
Message-ID: <1342532841.54512.YahooMailNeo@web140804.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

I don't know what has happened with the patch(es).
I used git format-patch to export them. I had to copy them to another PC to send the emails, so perhaps that's the problem.

Re: 'wmt' - as Alexey mentioned, this is the name the vendor uses in their own sources so it seemed like the obvious choice. I will post on devicetree-discuss and see what they think.

Regard,
Tony P



________________________________
 From: Arnd Bergmann <arnd@arndb.de>
To: Tony Prisk <linux@prisktech.co.nz> 
Cc: "vt8500-wm8505-linux-kernel at googlegroups.com" <vt8500-wm8505-linux-kernel@googlegroups.com>; devicetree-discuss at lists.ozlabs.org; Russell King <linux@arm.linux.org.uk>; "linux-kernel at vger.kernel.org" <linux-kernel@vger.kernel.org>; "linux-arm-kernel at lists.infradead.org" <linux-arm-kernel@lists.infradead.org> 
Sent: Wednesday, 18 July 2012 12:50 AM
Subject: Re: [PATCH 1/1] Add Wondermedia Technologies (wmt) to docs/devicetree/vendor-bindings.txt
 
On Tuesday 17 July 2012, Tony Prisk wrote:
> From 756ae5c2f475d679649adff99058679b651af8d9 Mon Sep 17 00:00:00 2001
> From: Tony Prisk <linux@prisktech.co.nz>
> Date: Tue, 17 Jul 2012 19:09:31 +1200
> Subject: [PATCH] Add Wondermedia Technologies (wmt) to vendor-prefixes.txt
>? Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

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

??? Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120717/20b07317/attachment.html>
