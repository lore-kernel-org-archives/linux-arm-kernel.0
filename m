From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Jan 2010 17:47:37 +0000
Subject: [PATCH] stack2core: show stack message and convert it to core
	file when kernel die
In-Reply-To: <daef60381001030939r60315c1dy56025a041a8ee758@mail.gmail.com>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
	<20100103160313.GA21156@n2100.arm.linux.org.uk>
	<daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com>
	<20100103164414.GB21156@n2100.arm.linux.org.uk>
	<daef60381001030855o3a39c3fdr879e2634fb85c491@mail.gmail.com>
	<20100103092608.0a04c664@infradead.org>
	<daef60381001030939r60315c1dy56025a041a8ee758@mail.gmail.com>
Message-ID: <20100103174737.GD21156@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2010 at 01:39:44AM +0800, Hui Zhu wrote:
> scripts/markup_oops.pl just support x86?
> s2c support x86, x8664, arm, mips, mips64.

I'm sure there's patches around to make it work on ARM, or if not,
there soon will be.  There's certainly patches around at the moment
to make scripts/decodecode work on ARM.
