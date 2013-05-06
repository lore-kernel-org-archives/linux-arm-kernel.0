From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 06 May 2013 14:30:16 -0000
Subject: [patch 0/8] genirq: Support for irq domains in generic irq chip - V2
In-Reply-To: <20130503212258.385818955@linutronix.de>
Message-ID: <20130506142348.321859745@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes vs. V1:

	- Fixed the generic chip pointer thinko (Sebastian Hesselbarth)

	- Proper support for mask cache

	- Read mask hardware only for the first map of an generic chip
          instance

	- sun4i prefix irq functions proper  

Thanks,

	tglx
