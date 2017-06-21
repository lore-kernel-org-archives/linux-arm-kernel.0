From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Jun 2017 18:28:39 +0200
Subject: [RFT PATCH v2 00/42] PCI: ARM/ARM64: remove pci_fixup_irqs() usage
In-Reply-To: <20170621154136.GA1362@red-moon>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <CACRpkdZ1rBq9eLJkz_gRuXAG=if+xXf-jPzDEPCfG8EgUmUG3A@mail.gmail.com>
 <20170621103042.GA1712@red-moon> <20170621104538.GA8477@red-moon>
 <CACRpkda_6=qWRQDpTy67MFc=-fYRhqWDPx0NnNG5mjXQLyAAkw@mail.gmail.com>
 <20170621154136.GA1362@red-moon>
Message-ID: <CACRpkdY7tyXZKekyOnXfh8sQuqywHtmZkuK1k55pGXo5Q84nmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 5:41 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> Is the ftpci100.c clock handling being queued for this merge window ?

Yups, it's in Bjorn's tree and visible in linux-next.

> This patch:
>
> https://patchwork.ozlabs.org/patch/778716/
>
> fixes a commit that is not in v4.12-rc6, I need some input to understand
> how to proceed.

Yeah that is just a fix I had to do when fixing this other issue.

It's cool, I just sent a patch. If Bjorn applied your series he can just
apply this on top and all will be fine (for me).

Yours,
Linus Walleij
