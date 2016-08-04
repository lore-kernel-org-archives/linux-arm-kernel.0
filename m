From: robh@kernel.org (Rob Herring)
Date: Thu, 4 Aug 2016 13:18:43 -0500
Subject: [PATCH v2 13/17] ARM: dts: mvebu: armada-395: add support for
 the Armada 395 SoC family
In-Reply-To: <1470305660-6601-14-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
 <1470305660-6601-14-git-send-email-jaz@semihalf.com>
Message-ID: <20160804181843.GA17494@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 12:14:16PM +0200, Grzegorz Jaszczyk wrote:
> Beside interfaces described in the armada-39x.dtsi, the Armada 395 SoC
> family supports: 2 x SATA3 (2 ports in one unit) and the USB3.0
> 
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
>  .../devicetree/bindings/arm/marvell/armada-39x.txt | 11 +++-
>  arch/arm/boot/dts/armada-395.dtsi                  | 76 ++++++++++++++++++++++
>  2 files changed, 85 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/armada-395.dtsi

Acked-by: Rob Herring <robh@kernel.org>
