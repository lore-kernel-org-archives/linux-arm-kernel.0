From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 9 Feb 2017 14:53:07 +0000
Subject: [QUESTION] Early Write Acknowledge for PCIe configuration space
In-Reply-To: <20170209143805.GA31693@red-moon>
References: <df407f39-ee05-d74d-6e5e-c5e502372032@huawei.com>
 <6092525.UgRCY3dpzP@wuerfel> <20170106114231.GC15333@arm.com>
 <20170208183530.GA27720@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E1FA25E1C@lhreml507-mbx>
 <20170209143805.GA31693@red-moon>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1FA270C0@lhreml507-mbx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> 
> I share Will's concern on the _uc API, I will probably add a
> pci_remap_cfgspace() API that would fall back to ioremap_nocache()
> by default (ie if the arch does not override it).
> 
> Adding a devm_ioremap_* version seems overkill to me.
> 
> I will send a patch series, we will take it from there.

Sure

Many thanks for this

Gab

> 
> Cheers,
> Lorenzo
