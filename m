From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 15 Apr 2017 15:10:46 +0100
Subject: [PATCH] irqchip/irq-imx-gpcv2: fix spinlock initialization
In-Reply-To: <alpine.DEB.2.20.1704151554220.2327@nanos> (Thomas Gleixner's
 message of "Sat, 15 Apr 2017 15:54:54 +0200")
References: <20170413222731.5917-1-tyler.baker@linaro.org>
 <87bmrxpz58.fsf@on-the-bus.cambridge.arm.com>
 <alpine.DEB.2.20.1704151554220.2327@nanos>
Message-ID: <877f2lpxqx.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 15 2017 at  2:54:54 pm BST, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sat, 15 Apr 2017, Marc Zyngier wrote:
>> 
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>> 
>> Thomas, any chance you could take this as a fix through the tip tree?
>
> It's in Linus tree already :)

Ah, that's how you can tell I'm on holiday... ;-)

	M.
-- 
Jazz is not dead, it just smell funny.
