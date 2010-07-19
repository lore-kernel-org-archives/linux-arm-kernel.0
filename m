From: mbohan@codeaurora.org (Michael Bohan)
Date: Mon, 19 Jul 2010 10:55:15 -0700
Subject: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
	memory management
In-Reply-To: <20100716075856.GC16124@n2100.arm.linux.org.uk>
References: <4C3C0032.5020702@codeaurora.org>
	<20100713150311B.fujita.tomonori@lab.ntt.co.jp>
	<20100713121420.GB4263@codeaurora.org>
	<20100714104353B.fujita.tomonori@lab.ntt.co.jp>
	<20100714201149.GA14008@codeaurora.org>
	<20100714220536.GE18138@n2100.arm.linux.org.uk>
	<20100715012958.GB2239@codeaurora.org>
	<20100715085535.GC26212@n2100.arm.linux.org.uk>
	<AANLkTinVZeaZxt_lWKhjKa0dqhu3_j3BRNySO-2LvMdw@mail.gmail.com>
	<20100716075856.GC16124@n2100.arm.linux.org.uk>
Message-ID: <4C449183.20000@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 7/16/2010 12:58 AM, Russell King - ARM Linux wrote:

> As the patch has been out for RFC since early April on the linux-arm-kernel
> mailing list (Subject: [RFC] Prohibit ioremap() on kernel managed RAM),
> and no comments have come back from Qualcomm folk.

Would it be unreasonable to allow a map request to succeed if the 
requested attributes matched that of the preexisting mapping?

Michael

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
