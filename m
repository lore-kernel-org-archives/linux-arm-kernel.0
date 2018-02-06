From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 07 Feb 2018 09:31:49 +1100
Subject: [PATCH 1/2] of_pci_irq: add a check to fallback to standard
 device tree parsing
In-Reply-To: <1517895732.23319.21.camel@mtkswgap22>
References: <31c765c53e85e41bfc001d110d69e46c9967f4e7.1516961656.git.ryder.lee@mediatek.com>
 <CAL_JsqLZqrxxpuEnoWEGkT2WCuyjqn0bM1DP8PdAwnQsso8kOA@mail.gmail.com>
 <1517563970.24622.9.camel@mtkswgap22>
 <1517866584.2312.140.camel@kernel.crashing.org>
 <1517884738.16010.27.camel@mtkswgap22>
 <1517889903.2312.151.camel@kernel.crashing.org>
 <1517891471.20869.6.camel@mtkswgap22>
 <1517892624.2312.167.camel@kernel.crashing.org>
 <1517895732.23319.21.camel@mtkswgap22>
Message-ID: <1517956309.2312.172.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-02-06 at 13:42 +0800, Ryder Lee wrote:
> Thanks for explanation.
> 
> So I guess the better way to achieve my aim - one IRQ per slot that is
> connected to all INTx and get propagated through the bridges (and for
> those root ports own interrupts (PME ..)} is to add interrupt-map
> properties in both parent and root port nodes.
> 
> Something like this: https://patchwork.kernel.org/patch/9970923// ,right?

Yup.

Cheers,
Ben.
