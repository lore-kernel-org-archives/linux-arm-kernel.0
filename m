From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 3 Jan 2010 19:32:11 +0100
Subject: [PATCH] stack2core: show stack message and convert it to core
	file when kernel die
In-Reply-To: <20100103174737.GD21156@n2100.arm.linux.org.uk>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
	<daef60381001030939r60315c1dy56025a041a8ee758@mail.gmail.com>
	<20100103174737.GD21156@n2100.arm.linux.org.uk>
Message-ID: <201001031932.11210.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Ne 3. ledna 2010 18:47:37 Russell King - ARM Linux napsal(a):
> On Mon, Jan 04, 2010 at 01:39:44AM +0800, Hui Zhu wrote:
> > scripts/markup_oops.pl just support x86?
> > s2c support x86, x8664, arm, mips, mips64.
> 
> I'm sure there's patches around to make it work on ARM, or if not,
> there soon will be.

And if there are not, that's the place you should focus yourself on rather than 
duplicating work ...

> There's certainly patches around at the moment
> to make scripts/decodecode work on ARM.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
