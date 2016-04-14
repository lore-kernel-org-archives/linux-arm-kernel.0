From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Apr 2016 12:37:38 -0500
Subject: [PATCH v5 4/5] dt-bindings: arm: add DT binding for Marvell
 CP110 system controller
In-Reply-To: <1460648013-31320-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1460648013-31320-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1460648013-31320-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160414173738.GA24292@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 05:33:32PM +0200, Thomas Petazzoni wrote:
> This commit adds the DT binding documentation for the Marvell CP110
> system controller, which is part of the CP110 HW block, itself used in
> the Marvell Armada 7K and 8K SoCs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../arm/marvell/cp110-system-controller0.txt       | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt

Acked-by: Rob Herring <rob@kernel.org>
