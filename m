From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Mar 2011 11:51:28 +0000
Subject: [GIT PULL] u300, ux500 and Nomadik changes for v2.6.39
In-Reply-To: <AANLkTinjp4HDu7+hKXP7X2ELBrNAuVc4LXVBiRn720yj@mail.gmail.com>
References: <AANLkTikgMq4QbRGZ_3kkzeNBp9aD4YKa-0CRCfs1K57u@mail.gmail.com>
	<20110313214835.GA24370@n2100.arm.linux.org.uk>
	<AANLkTinjp4HDu7+hKXP7X2ELBrNAuVc4LXVBiRn720yj@mail.gmail.com>
Message-ID: <20110314115128.GE26085@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2011 at 12:46:14PM +0100, Linus Walleij wrote:
> I created a branch named "for-rmk-devel-stable" without the defconfig stuff,
> that lands entirely inside the arch/arm/* tree, it duplicates the two PMU
> patches and nothing else from your tree:
>       ARM: perf_event: allow platform-specific interrupt handler
>       mach-ux500: DB8500 PMU support

Don't want duplicated commits - its something that Linus has complained
about in the past with other people.

Why not base your tree off my devel-stable if the commits are already in
that branch?
