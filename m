From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 18 Jun 2015 15:23:18 +0200
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem,
 not booting since 3.8
In-Reply-To: <1478246.OrbqF8cmmQ@wuerfel>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <1434593555.13334.14.camel@dolka.fr> <558278A8.2050406@arm.com>
 <1478246.OrbqF8cmmQ@wuerfel>
Message-ID: <20150618132318.GA312@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Thomas Petazzoni has worked on converting orion5x machines to DT
> in the past, I've cc'd him and the mvebu maintainers here, they
> should be able to comment on what is actually required to do the
> conversion. It's possible that all drivers you need have already
> been converted and you just need to add a new dts files similar to
> the other arch/arm/boot/dts/orion5x-*.dts files and can remove
> that other board file.

I had a quick look at lsmini-setup.c. Everything it uses is DT ready,
so the conversion should be painless.

   Andrew
