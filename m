From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 14 Sep 2010 23:23:38 +0200
Subject: [PATCH] arm: fix pci_set_consistent_dma_mask for dmabounce devices
In-Reply-To: <20100906083105X.fujita.tomonori@lab.ntt.co.jp> (FUJITA
	Tomonori's message of "Mon, 6 Sep 2010 08:32:45 +0900")
References: <20100901085738.GJ8142@n2100.arm.linux.org.uk>
	<20100902114937X.fujita.tomonori@lab.ntt.co.jp>
	<20100905112513.GB558@n2100.arm.linux.org.uk>
	<20100906083105X.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <m34odsrpd1.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> writes:

>> > From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
>> > Subject: [PATCH] arm: fix arm: fix pci_set_consistent_dma_mask for dmabounce devices
>> > 
>> > This fixes the regression caused by the commit
>> > 6fee48cd330c68332f9712bc968d934a1a84a32a.


>> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> Should I send this to Linus? Or Can I assume that someone in ARM camp
> will do?

It would be nice if you do. TIA.
-- 
Krzysztof Halasa
