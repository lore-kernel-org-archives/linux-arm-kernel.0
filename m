From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 20 Sep 2016 22:16:52 +0200 (CEST)
Subject: [PATCH v6 2/4] drivers: irqchip: Add STM32 external interrupts
 support
In-Reply-To: <1474387259-18926-3-git-send-email-alexandre.torgue@st.com>
References: <1474387259-18926-1-git-send-email-alexandre.torgue@st.com>
 <1474387259-18926-3-git-send-email-alexandre.torgue@st.com>
Message-ID: <alpine.DEB.2.20.1609202214460.5476@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre,

On Tue, 20 Sep 2016, Alexandre TORGUE wrote:

> The STM32 external interrupt controller consists of edge detectors that
> generate interrupts requests or wake-up events.
> 
> Each line can be independently configured as interrupt or wake-up source,
> and triggers either on rising, falling or both edges. Each line can also
> be masked independently.
> 
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

That all looks very reasonable now. The only remaining question is your SOB
chain. Who is the author of these patches? You or Maxime? If it's Maxime,
then the changelog misses a From: tag. If it's you then Maximes SOB is
bogus.

Thanks,

	tglx
