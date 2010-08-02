From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Aug 2010 10:22:33 +0100
Subject: Please remind 'WARNING: about Samsung merge window over'
In-Reply-To: <AANLkTim1qtiYzvGKKRDcgt-Wds30qVX27GDMcnquOvBP@mail.gmail.com>
References: <003401cb3206$d68a1fc0$839e5f40$%kim@samsung.com>
	<AANLkTimJvS0djVprEgCJ8k3_SYeaKc72NMNZNrRpqXHi@mail.gmail.com>
	<20100802073138.GB10608@n2100.arm.linux.org.uk>
	<AANLkTim1qtiYzvGKKRDcgt-Wds30qVX27GDMcnquOvBP@mail.gmail.com>
Message-ID: <20100802092233.GB30670@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 02, 2010 at 05:35:37PM +0900, Kyungmin Park wrote:
> As the maintainer, he merged his features freely but others can't get
> the chance if the implementation is not fit his taste or company
> policy.
> 
> Look at the example.
> [PATCH v2 0/4] ARM: S5P: Support gpio interrupts
> http://marc.info/?l=linux-arm-kernel&m=127840208508625&w=2
> 
> We need the gpio interrupt support but he refused it since it used too
> many irq. Actually his board don't use this features.
> "It is because there are too many gpio interrupts and having support
> of all of them is unnecessary as realistically only few of them maybe
> used."
