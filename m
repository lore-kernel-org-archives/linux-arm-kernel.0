From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Apr 2016 08:05:57 -0500
Subject: [PATCH v6 7/7] ARM: dts: DRA7: Add dt nodes for PWMSS
In-Reply-To: <1461343238-29274-8-git-send-email-fcooper@ti.com>
References: <1461343238-29274-1-git-send-email-fcooper@ti.com>
 <1461343238-29274-8-git-send-email-fcooper@ti.com>
Message-ID: <20160425130557.GA11485@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 11:40:38AM -0500, Franklin S Cooper Jr wrote:
> From: Vignesh R <vigneshr@ti.com>
> 
> Add PWMSS device tree nodes for DRA7 SoC family and add documentation
> for dt bindings.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> [fcooper at ti.com: Add eCAP and use updated bindings for PWMSS and ePWM]
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  .../devicetree/bindings/pwm/pwm-tiecap.txt         |  9 +++
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  9 +++
>  .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 15 +++-
>  arch/arm/boot/dts/dra7.dtsi                        | 90 ++++++++++++++++++++++
>  4 files changed, 122 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
