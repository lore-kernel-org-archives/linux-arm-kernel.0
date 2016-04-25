From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Apr 2016 08:04:31 -0500
Subject: [PATCH v6 5/7] ARM: dts: am437x/am33xx: Remove hwmod entries for
 ECAP and EPWM nodes
In-Reply-To: <1461343238-29274-6-git-send-email-fcooper@ti.com>
References: <1461343238-29274-1-git-send-email-fcooper@ti.com>
 <1461343238-29274-6-git-send-email-fcooper@ti.com>
Message-ID: <20160425130431.GA10953@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 11:40:36AM -0500, Franklin S Cooper Jr wrote:
> Previous patches switched the ECAP and EPWM to use the new bindings.
> These bindings explicitly adds the various required clocks via DT rather
> than depending on hwmod.
> 
> Therefore, it is safe to remove the hwmod entries since they are no longer
> needed.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt   | 3 ---
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 3 ---
>  arch/arm/boot/dts/am33xx.dtsi                          | 6 ------
>  arch/arm/boot/dts/am4372.dtsi                          | 9 ---------
>  4 files changed, 21 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
