From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Sat, 22 Feb 2014 08:32:03 +0100
Subject: [PATCH v7 8/8] ARM: sunxi: Add documentation for driver for
 SD/MMC hosts found on Allwinner sunxi SoCs
In-Reply-To: <20140218154212.GL3142@lukather>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100302.15040.56273.stgit@pagira.o2s.ch>
 <20140218154212.GL3142@lukather>
Message-ID: <1559221.mEv19UvCzF@pagira.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> Please use the real compatibles here. It's much easier to search
> for. Plus, your driver doesn't support all the SoCs you're mentionning here.
> [...]
> Please provide the real property name to use. No need for an example
> here, you have a full-fledged one in a few lines.
Fixed that.
> Ditto. Plus, this is not a mod0 clock.
Yes it is! But maybe the formulation hasn't been clear enough...
> You never talked about the clock-names property, and which clocks were
> supposed to be provided.
Yes I did? But I expanded the text a little bit further...
> > +	interrupts = <0 32 4>;
> > +	bus-width = <4>;
> And you never talked about bus-width either.
I can throw in a line for refering to the mmc slot gpio lib docs.
> Isn't the cd-gpios property requested too?
I can refer to the docs there as well if you like... :-)

cheers
david
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140222/909a1b3a/attachment.sig>
