From: davem@davemloft.net (David Miller)
Date: Fri, 26 Dec 2014 17:06:34 -0500 (EST)
Subject: [PATCH] net: xilinx: Remove unnecessary temac_property in the
 driver
In-Reply-To: <072fa5b149374b09b3f6d5d767714d3e@BN1AFFO11FD010.protection.gbl>
References: <072fa5b149374b09b3f6d5d767714d3e@BN1AFFO11FD010.protection.gbl>
Message-ID: <20141226.170634.1467105628556822771.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kedareswara rao Appana <appana.durga.rao@xilinx.com>
Date: Tue, 23 Dec 2014 18:07:55 +0530

> This property is no longer used in the code yet the code looks for it in the device tree.
> It does not cause an error if it's not in the tree.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>

Applied, thanks.
