From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Sep 2014 14:51:16 +0200
Subject: Formal license ambiguity in arch/arm/boot/dts/sun?i-a*.dts
In-Reply-To: <5405B986.2080407@redhat.com>
References: <20140731192016.GA6869@excalibur.cnev.de>
 <20140803130430.GY3952@lukather> <201408031959.27607.arnd@arndb.de>
 <20140804192510.GF3952@lukather>
 <20140804212317.GL30282@n2100.arm.linux.org.uk>
 <20140807132023.GG15297@lukather> <20140902102206.GU15297@lukather>
 <20140902104002.GN30401@n2100.arm.linux.org.uk>
 <20140902122716.GV15297@lukather> <5405B986.2080407@redhat.com>
Message-ID: <20140902125116.GW15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 02:35:18PM +0200, Hans de Goede wrote:
> > So I guess like Chen-Yu suggested that we should change the license of
> > the DTSI first, and then the DTS. Otherwise, it wouldn't work very
> > well, I guess you can't really relicense a GPL-only file.
> 
> IANAL, but mixing MIT (which I suggest use as the other license) and GPL
> files in one binary (the generated dtb file) is fine AFAIK, this happens
> all the time. The resulting binary is simple GPL licensed. So it would
> make sense to start with dual licensing new boards right away even before
> the dtsi has been relicensed. It won't make any practical difference
> until the dtsi is relicensed, but it means less work later on.

So you're allowed to licence derivative work of a GPL-licenced file
under both the GPL and another licence?

And as far as MIT vs BSD is concerned, I don't really have an
opinion. Arnd? Russell?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140902/b995c0b1/attachment.sig>
