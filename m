From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 02 Aug 2018 15:03:15 +0200
Subject: [PATCH v3 1/4] dt-bindings: usb: dwc2: add description for px30
In-Reply-To: <1533113116-8820-2-git-send-email-cl@rock-chips.com>
References: <1533113116-8820-1-git-send-email-cl@rock-chips.com>
 <1533113116-8820-2-git-send-email-cl@rock-chips.com>
Message-ID: <1906917.Z0b3HQLJhP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 1. August 2018, 10:45:13 CEST schrieb cl at rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch adds the compatible of dwc2 for PX30 SoCs.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Liang Chen <cl@rock-chips.com>

I've split out the dwc2 things from the px30 dts and readded them
in a new series and also moved the binding addition over there [0]

Heiko

[0] https://patchwork.kernel.org/cover/10553569/
