From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Aug 2016 13:36:28 -0500
Subject: [PATCH 1/4] dt-bindings: interrupt-controller: add DT binding
 for Marvell 7K/8K PIC
In-Reply-To: <1470408921-447-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1470408921-447-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160810183628.GA11887@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2016 at 04:55:18PM +0200, Thomas Petazzoni wrote:
> This commit adds the Device Tree binding description for the PIC
> interrupt controller available in the ARM64 Marvell Armada 7K/8K SoCs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../interrupt-controller/marvell,armada-8k-pic.txt | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,armada-8k-pic.txt

Acked-by: Rob Herring <robh@kernel.org>
