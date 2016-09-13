From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Sep 2016 09:19:01 +0100
Subject: [PATCH v5 2/9] drivers: irqchip: Add STM32 external interrupts
 support
In-Reply-To: <1473432124-6784-3-git-send-email-alexandre.torgue@st.com>
References: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
 <1473432124-6784-3-git-send-email-alexandre.torgue@st.com>
Message-ID: <57D7B675.1060904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/16 15:41, Alexandre TORGUE wrote:
> The STM32 external interrupt controller consists of edge detectors that
> generate interrupts requests or wake-up events.
> 
> Each line can be independently configured as interrupt or wake-up source,
> and triggers either on rising, falling or both edges. Each line can also
> be masked independently.
> 
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
