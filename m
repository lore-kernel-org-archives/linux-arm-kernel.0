From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 20 Dec 2014 21:07:53 +0100
Subject: [PATCH v2 3/4] arm64: dts: Add mediatek MT8173 SoC and evaluation
 board dts and Makefile
In-Reply-To: <54919AC9.2090306@arm.com>
References: <1418825853-10934-1-git-send-email-eddie.huang@mediatek.com>
 <20141217143305.GC8942@leverpostej> <54919AC9.2090306@arm.com>
Message-ID: <3669965.zfJEHTFEBI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 December 2014 15:01:29 Marc Zyngier wrote:
> 
> Indeed, as described in the documentation:
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0471b/CHDIFAEE.html
> 
> Also it is worth noticing that given how GICV is placed, it will never
> work with 64K pages and virtualization. Pretty sad.

Does this mean no VGIC support on this platform so you have to emulate it
in order to run virtual machines with 64K pages, or does it mean that
it's impossible to use that way because you can't emulate it?

	Arnd
