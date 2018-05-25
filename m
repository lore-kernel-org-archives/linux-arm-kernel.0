From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 25 May 2018 22:10:12 +0200
Subject: [PATCH] ARM: dts: pxa3xx: fix MMC clocks
In-Reply-To: <20180524174339.12236-1-daniel@zonque.org> (Daniel Mack's message
 of "Thu, 24 May 2018 19:43:39 +0200")
References: <20180524174339.12236-1-daniel@zonque.org>
Message-ID: <87o9h3wl7f.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> The clocks for the 3 MMC controllers on pxa3xx platforms are CLK_MMC1,
> CLK_MMC2 and CLK_MMC3. CLK_MMC is only for pxa2xx.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
Very true.

Queued to pxa/dt.

--
Cheers.
