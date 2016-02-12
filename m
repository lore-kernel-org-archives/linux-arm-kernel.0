From: robh@kernel.org (Rob Herring)
Date: Fri, 12 Feb 2016 08:49:10 -0600
Subject: [PATCH v3 08/12] devicetree: bindings: add DT binding for the
 Marvell Armada 3700 SoC family
In-Reply-To: <1454951660-13289-9-git-send-email-gregory.clement@free-electrons.com>
References: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
 <1454951660-13289-9-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160212144910.GA11975@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 06:14:16PM +0100, Gregory CLEMENT wrote:
> The Marvell Armada 3700 is a family of ARMv8 CA53 SoCs. This commit
> introduces the Device Tree binding that documents the top-level
> compatible strings for Armada 3700 based platforms.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/arm/marvell/armada-37xx.txt      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt

Acked-by: Rob Herring <robh@kernel.org>
