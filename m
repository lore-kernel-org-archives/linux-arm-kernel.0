From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Jun 2015 16:48:50 +0100
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem,
 not booting since 3.8
In-Reply-To: <20150619152552.GF2936@io.lakedaemon.net>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <1434446447.4785.7.camel@dolka.fr>
 <1434593555.13334.14.camel@dolka.fr> <558278A8.2050406@arm.com>
 <1434677895.4767.11.camel@dolka.fr> <5583DD23.90505@arm.com>
 <1434716194.17448.28.camel@x60s>
 <20150619131315.GR7557@n2100.arm.linux.org.uk>
 <d6d361113992920900137899ae4d1f7b@dolka.fr>
 <20150619152552.GF2936@io.lakedaemon.net>
Message-ID: <20150619154850.GT7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 03:25:52PM +0000, Jason Cooper wrote:
> Let's just get the dts patch reviewed and merged first.  Russell
> actually wrote the patch to do what he's describing for mach-dove.
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309684.html
> 
> Although, it looks like it never got updated for submission...
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311800.html

I do still have that patch, it's based on v4.0 though - like all my
Dove work, it only builds on the previous -final kernel release.

"Getting it out there" is really low on my priority list because of
the amount of hassle involved in trying to get anything merged (read
that as: I've basically given up trying anymore because of the amount
of back pressure from people who don't read the comments from the
previous submission, and end up making the same old comments every
time - thereby ensuring that there is little in the way of forward
progress.  No, we're not using syscon nor regmap for the PMU...)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
