From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Aug 2015 22:44:35 +0200
Subject: [PATCH 3/6] ARM: dts: sun6i: hummingbird: Use axp221.dtsi for
 axp221 regulators
In-Reply-To: <CAGb2v67wEXNTDYrPm9Hf2P59+B4nGHAR8kTPCuLVuS+TLHxMRQ@mail.gmail.com>
References: <1440755679-8266-1-git-send-email-wens@csie.org>
 <1440755679-8266-4-git-send-email-wens@csie.org>
 <20150828123244.GK29389@lukather>
 <CAGb2v67wEXNTDYrPm9Hf2P59+B4nGHAR8kTPCuLVuS+TLHxMRQ@mail.gmail.com>
Message-ID: <20150828204435.GT29389@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 29, 2015 at 12:47:00AM +0800, Chen-Yu Tsai wrote:
> >> +&reg_dcdc3 {
> >> +     regulator-always-on;
> >> +     regulator-min-microvolt = <700000>;
> >> +     regulator-max-microvolt = <1320000>;
> >> +     regulator-name = "vdd-gpu";
> >> +};
> >
> > I'm know it's just a mechanical change from your part, but is the GPU
> > regulator really need to be always on?
> 
> I don't think so. It shouldn't affect anything else, though I can't
> think of a way to thoroughly test it. Maybe I just disable it for.
> If anyone complains later on when adding new peripherals they can
> turn it back on.

Sounds good. That also applies to your other patches though.

Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150828/91bb260f/attachment.sig>
