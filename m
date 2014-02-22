From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 22 Feb 2014 09:37:18 +0100
Subject: [PATCH v7 8/8] ARM: sunxi: Add documentation for driver for
 SD/MMC hosts found on Allwinner sunxi SoCs
In-Reply-To: <1559221.mEv19UvCzF@pagira.o2s.ch>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100302.15040.56273.stgit@pagira.o2s.ch>
 <20140218154212.GL3142@lukather> <1559221.mEv19UvCzF@pagira.o2s.ch>
Message-ID: <20140222083718.GI3931@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Sat, Feb 22, 2014 at 08:32:03AM +0100, David Lanzend?rfer wrote:
> > Ditto. Plus, this is not a mod0 clock.
> Yes it is! But maybe the formulation hasn't been clear enough...

Technically, it's not, it has this phase controls features a mod0
clock doesn't have.

> > You never talked about the clock-names property, and which clocks
> > were supposed to be provided.
>
> Yes I did? But I expanded the text a little bit further...

I can't see any reference to the fact that clock-names should be set,
and what values should it hold.

Something like that:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt#n11

> > > +	interrupts = <0 32 4>;
> > > +	bus-width = <4>;
> > And you never talked about bus-width either.
> I can throw in a line for refering to the mmc slot gpio lib docs.

Yes, that would be great :)

> > Isn't the cd-gpios property requested too?
> I can refer to the docs there as well if you like... :-)

That would be great too :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140222/1840615a/attachment.sig>
