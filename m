From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Oct 2011 13:15:48 +0100
Subject: [PATCH 3/9] ARM: SPMP8000: Add clk support
In-Reply-To: <CAGVye5Oy8M3+PBZN2KXMmnstBtxngb0feYELgbnu5ZWxZBHLEw@mail.gmail.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-4-git-send-email-zoss@devai.org>
	<20111013093836.GK21648@n2100.arm.linux.org.uk>
	<CAGVye5Oy8M3+PBZN2KXMmnstBtxngb0feYELgbnu5ZWxZBHLEw@mail.gmail.com>
Message-ID: <20111017121548.GH5448@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 16, 2011 at 04:16:45PM +0200, Zoltan Devai wrote:
> 2011/10/13 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> > I find the use of 'scu' for something which isn't the SMP Coherence Unit
> > rather confusing - and I suspect you will too if/when spmp8000 has SMP
> > support.

> Well, Sunplus decided to name these devices 'SCU', which are a collection
> of reset, clock, debug, pinmux and gpio stuff.
> The datasheet doesn't even tell what SCU stands for, but I'd prefer to keep
> the naming to be in sync with the documentation.

System Control Unit.  It's a fairly common name to use for the core
system glue logic.
