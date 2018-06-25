From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 25 Jun 2018 22:18:03 +0200
Subject: [PATCH] arm: dts: pxa3xx: provide correct clk-names property for
 nand controller node
In-Reply-To: <20180624174205.20648-1-daniel@zonque.org> (Daniel Mack's message
 of "Sun, 24 Jun 2018 19:42:05 +0200")
References: <20180624174205.20648-1-daniel@zonque.org>
Message-ID: <87po0emxhg.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> The NAND driver looks for a clock named "core" and falls back to a pdev
> clock that has a wrong rate if not set.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
Applied to pxa/dt with a small "line swap", ie. clock-names is one line below
"clocks" line.

Cheers.

-- 
Robert
