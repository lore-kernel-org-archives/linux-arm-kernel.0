From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Fri, 13 Jan 2017 17:22:44 +0000
Subject: [PATCH 07/37] PCI: dwc: designware: Get device pointer at the
 start of dw_pcie_host_init
In-Reply-To: <1484216786-17292-8-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-8-git-send-email-kishon@ti.com>
Message-ID: <fbfa32a8-0897-9c8a-618c-bb41fa26c532@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi!

?s 10:25 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
> No functional change. Get device pointer at the beginning of
> dw_pcie_host_init instead of getting it all over dw_pcie_host_init.
> This is in preparation for splitting struct pcie_port into host and
> core structures (Once split pcie_port will not have device pointer).
> 

I think change should be condense with another patch to reduce the patch-set
number and to give it real meaning. I understand why you are breaking so much
the patch, it is has a lot of changes, but in my opinion is too much fragmented.

Thanks
Joao
