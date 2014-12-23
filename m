From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Dec 2014 22:07:45 +0100
Subject: [PATCH v2 3/4] arm64: dts: Add mediatek MT8173 SoC and evaluation
 board dts and Makefile
In-Reply-To: <72aa7f4069a000c6e39c53e328015aa3@www.loen.fr>
References: <1418825853-10934-1-git-send-email-eddie.huang@mediatek.com>
 <1419321723.14341.38.camel@mtksdaap41>
 <72aa7f4069a000c6e39c53e328015aa3@www.loen.fr>
Message-ID: <1947751.D0rZorCFoT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 December 2014 08:43:55 Marc Zyngier wrote:
> 
> > Neverthless, MT8173 SoC already use 0x10224000 and 0x10225000 as VGIC
> > base address.
> 
> Then its fate is sealed virtualization wise.

It should still work with 4kb pages on the host, right? Would that still
allow you to have 64kb pages on the guest, or does the guest page size
have to be smaller or equal to the host?

	Arnd
