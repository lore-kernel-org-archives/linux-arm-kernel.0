From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Sep 2014 15:02:02 +0200
Subject: Formal license ambiguity in arch/arm/boot/dts/sun?i-a*.dts
In-Reply-To: <20140902125116.GW15297@lukather>
References: <20140731192016.GA6869@excalibur.cnev.de>
 <5405B986.2080407@redhat.com> <20140902125116.GW15297@lukather>
Message-ID: <353751667.DmppNpqdli@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014 14:51:16 Maxime Ripard wrote:
> On Tue, Sep 02, 2014 at 02:35:18PM +0200, Hans de Goede wrote:
> > > So I guess like Chen-Yu suggested that we should change the license of
> > > the DTSI first, and then the DTS. Otherwise, it wouldn't work very
> > > well, I guess you can't really relicense a GPL-only file.
> > 
> > IANAL, but mixing MIT (which I suggest use as the other license) and GPL
> > files in one binary (the generated dtb file) is fine AFAIK, this happens
> > all the time. The resulting binary is simple GPL licensed. So it would
> > make sense to start with dual licensing new boards right away even before
> > the dtsi has been relicensed. It won't make any practical difference
> > until the dtsi is relicensed, but it means less work later on.
> 
> So you're allowed to licence derivative work of a GPL-licenced file
> under both the GPL and another licence?
> 
> And as far as MIT vs BSD is concerned, I don't really have an
> opinion. Arnd? Russell?

libfdt uses BSD license, which would be a reason to use the same for
the dts files. Other than that, I don't think it matters either way.

	Arnd
