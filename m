From: robh@kernel.org (Rob Herring)
Date: Thu, 28 Apr 2016 16:35:45 -0500
Subject: [PATCH v7 5/9] ARM: dts: am437x/am33xx/da850: Add new ECAP and
 EPWM bindings
In-Reply-To: <1461710209-6563-6-git-send-email-fcooper@ti.com>
References: <1461710209-6563-1-git-send-email-fcooper@ti.com>
 <1461710209-6563-6-git-send-email-fcooper@ti.com>
Message-ID: <20160428213545.GA28119@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 05:36:45PM -0500, Franklin S Cooper Jr wrote:
> Switch to a new ECAP and EPWM bindings that doesn't depend on hwmod to
> provide the various required clocks.
> 
> For AM437 and AM335x, add the required clocks explicitly to DT. The
> hwmod entries for ECAP and EPWM will be removed and this will prevent
> anything from breaking.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  .../devicetree/bindings/pwm/pwm-tiecap.txt         | 18 +++++---
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       | 18 +++++---
>  arch/arm/boot/dts/am33xx.dtsi                      | 30 +++++++++---
>  arch/arm/boot/dts/am4372.dtsi                      | 54 ++++++++++++++++++----
>  arch/arm/boot/dts/da850.dtsi                       | 15 ++++--
>  5 files changed, 103 insertions(+), 32 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
