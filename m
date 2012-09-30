From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 30 Sep 2012 19:01:59 +0200
Subject: ARM SoC tree,
 Was: Re: [PATCH 05/12] ARM: ixp4xx: use __iomem for MMIO
In-Reply-To: <20120929215355.GD6933@n2100.arm.linux.org.uk> (Russell King's
 message of "Sat, 29 Sep 2012 22:53:55 +0100")
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-6-git-send-email-arnd@arndb.de>
 <m3lift6rru.fsf_-_@intrepid.localdomain>
 <201209291458.16112.arnd@arndb.de>
 <m3y5jskbir.fsf@intrepid.localdomain>
 <20120929174400.GA6933@n2100.arm.linux.org.uk>
 <m3pq54jyqw.fsf@intrepid.localdomain>
 <20120929215355.GD6933@n2100.arm.linux.org.uk>
Message-ID: <m3vcevtpfc.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> Note I'm not only doing ARM, but also X86 and MIPS, with additional code
>> shared between them, and the "stable" part of it is what I'm paid for.
>> I can't simply work with arm-soc, none of my platforms will even boot
>> with pure arm-soc.
>
> I'm assuming that Linus' -rc kernels work for you, yes?

No, but it's OK :-)

I meant I need additional code for a) ARM and MIPS-based boards (off the
shelf by Ubiquity, Gateworks etc., support ported mostly from OpenWRT),
b) custom hardware used only by us.

I hope to eventually submit a) upstream, then arm-soc and Linus' trees
would work for me. I know it's a mess, but for now I have no options.

BTW the situation with hardware supported only by OpenWRT is a part of
the equation.
-- 
Krzysztof Halasa
