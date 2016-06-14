From: robh@kernel.org (Rob Herring)
Date: Tue, 14 Jun 2016 07:37:40 -0500
Subject: [PATCH 05/10] dt-bindings: clock: add DT binding for the Xtal
 clock on Armada 3700
In-Reply-To: <1465565018-14172-6-git-send-email-gregory.clement@free-electrons.com>
References: <1465565018-14172-1-git-send-email-gregory.clement@free-electrons.com>
 <1465565018-14172-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160614123740.GA31855@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 03:23:33PM +0200, Gregory CLEMENT wrote:
> This commit adds the DT binding documentation for the the Xtal clock on
> Armada 3700 used in the Marvell Armada 3700 SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../bindings/clock/armada3700-xtal-clock.txt       | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt

Acked-by: Rob Herring <robh@kernel.org>
