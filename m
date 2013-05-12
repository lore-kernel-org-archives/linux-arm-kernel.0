From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 12 May 2013 16:14:19 +0200
Subject: [patch 8/8] irqchip: sun4i: Convert to generic irq chip
In-Reply-To: <518FA24D.80203@free-electrons.com>
References: <20130503212258.385818955@linutronix.de>
 <20130506142348.321859745@linutronix.de>
 <20130506142539.523110430@linutronix.de> <518FA24D.80203@free-electrons.com>
Message-ID: <518FA3BB.7060806@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/05/2013 16:08, Maxime Ripard a ?crit :
> Hi Thomas,
> 
> Le 06/05/2013 16:30, Thomas Gleixner a ?crit :
>> Proof of concept patch to demonstrate the new irqdomain support for
>> the generic irq chip. Untested !!
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> I just tested it, and with the minor patch I sent, it's working fine.
> 
> You can add my
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

After addressing the comments RobH already made that is.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
