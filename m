From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 12:52:03 -0500
Subject: [PATCH 1/3] arm: dts: imx7: Update #pwm-cells for PWM polarity
 control
In-Reply-To: <20160919142347.11342-2-bhuvanchandra.dv@toradex.com>
References: <20160919142347.11342-1-bhuvanchandra.dv@toradex.com>
 <20160919142347.11342-2-bhuvanchandra.dv@toradex.com>
Message-ID: <20160923175202.GA2816@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 07:53:45PM +0530, Bhuvanchandra DV wrote:
> Update #pwm-cells to 3 in order to support PWM signal polarity control.
> 
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt | 6 +++---
>  arch/arm/boot/dts/imx7s.dtsi                      | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)

The driver will still work with old DTs, right? If so,

Acked-by: Rob Herring <robh@kernel.org>
