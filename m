From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Oct 2013 09:10:34 +0200
Subject: [PATCH v10 3/7] ARM: dts: enable hi4511 with device tree
In-Reply-To: <CAD6h2NTb8-8nSuaa6eQNYBFk3gv94TptZbX7xmz8WKFfCXZ5fg@mail.gmail.com>
References: <1381828577-27998-1-git-send-email-haojian.zhuang@linaro.org>
 <201310152018.10908.arnd@arndb.de>
 <CAD6h2NTb8-8nSuaa6eQNYBFk3gv94TptZbX7xmz8WKFfCXZ5fg@mail.gmail.com>
Message-ID: <201310160910.35093.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 October 2013, Haojian Zhuang wrote:
> > If you do that, it probably makes sense to move the clock controller under here
> > as well.
> Could I keep them into hi3620-clk.dtsi? Since both hi3620.dtsi &
> hi3620-clk.dtsi are not small, merge them together only make people
> reading hard.

Yes, of course. The location in the tree is independent of what file they
are in. I was just suggesting to have the "clocks" node under "amba".

	Arnd
