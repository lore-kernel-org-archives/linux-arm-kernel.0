From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Jan 2015 10:19:11 +0100
Subject: [linux-sunxi] Re: ARM: dts: sunxi: A20-OlinuXino-Lime2 raise
 dcdc2 lower voltage limit
In-Reply-To: <54AEBB92.9050909@gmail.com>
References: <54ADB179.9000209@gmail.com>
 <CAGb2v64xsLpQ63GuxDRj+X454f-FaHHqS+2QpEWEnvgVO2NFQA@mail.gmail.com>
 <54AEBB92.9050909@gmail.com>
Message-ID: <20150112091911.GF4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 05:17:06PM +0000, Iain Paton wrote:
> On 08/01/15 03:54, wens Tsai wrote:
> 
> > You should lower the maximum voltage as well, either in this patch
> > or when you redo all the regulators. AFAIK the SoC certainly cannot
> > take up to 2.275V. The regulator nodes are supposed to say what
> > the board can handle.
> 
> Yes, I suspect several of them are not currently sensible. I just used 
> the limits from the pmic datasheet at the time as there were no other 
> boards with axp209 regulator defined, no fex file for the lime2 etc.
> 
> I likely would have sent a full respin based on your patches, but as 
> only bits have been applied it seemed better to do this minimal one 
> and fix the rest properly later. 
> I can do a couple of the other Olimex boards that I have available 
> to test while I'm doing it.

All the meaningful patches should have been merged by now, so it would
be good if you could resend this with the proper limits for all the
regulators enabled.

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150112/6e083860/attachment.sig>
