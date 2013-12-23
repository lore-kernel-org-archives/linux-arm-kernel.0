From: tinamdar@apm.com (Tanmay Inamdar)
Date: Mon, 23 Dec 2013 14:26:25 +0530
Subject: [RFC PATCH 0/3] APM X-Gene PCIe driver
In-Reply-To: <1387785725-24262-1-git-send-email-tinamdar@apm.com>
References: <1387785725-24262-1-git-send-email-tinamdar@apm.com>
Message-ID: <CACoXjc=bC=O=MxHxMA8kYMdEGNufXeNR+oxENsLieErTRekLNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 1:32 PM, Tanmay Inamdar <tinamdar@apm.com> wrote:
> This patch adds support for AppliedMicro X-Gene PCIe host controller. The
> driver is tested on X-Gene platform with different gen1/2/3 PCIe endpoint
> cards.
>
> X-Gene PCIe controller driver has depedency on the pcie arch support for
> arm64. The arm64 pcie arch support is not yet part of mainline Linux kernel
> and approach for arch support is under discussion with arm64 maintainers.
> The reference patch can be found here --> https://lkml.org/lkml/2013/10/23/244
>
> If someone wishes to test PCIe on X-Gene, arch support patch must be applied
> before the patches in this patch set.
>
> Tanmay Inamdar (3):
>   pci: APM X-Gene PCIe controller driver
>   arm64: dts: APM X-Gene PCIe device tree nodes
>   dt-bindings: pci: xgene pcie device tree bindings
>
>  .../devicetree/bindings/pci/xgene-pcie.txt         |   43 +
>  arch/arm64/boot/dts/apm-mustang.dts                |    4 +
>  arch/arm64/boot/dts/apm-storm.dtsi                 |  140 +++
>  drivers/pci/host/Kconfig                           |    5 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pcie-xgene.c                      | 1017 ++++++++++++++++++++
>  6 files changed, 1210 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xgene-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-xgene.c
>
> --
> 1.7.9.5
>
This patch set might have been delivered to limited audience
previously because of some problem in my mail settings.

My apologies for spamming.

-Tanmay
