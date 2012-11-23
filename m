From: avinashphilip@ti.com (Philip, Avinash)
Date: Fri, 23 Nov 2012 10:35:01 +0000
Subject: [PATCH v4 09/11] ARM: dts: AM33XX: Add PWMSS device tree nodes
In-Reply-To: <20121122210857.GH16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-10-git-send-email-avinashphilip@ti.com>
 <20121122210857.GH16716@avionic-0098.adnet.avionic-design.de>
Message-ID: <518397C60809E147AF5323E0420B992E3E9EE9A9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 02:38:57, Thierry Reding wrote:
> On Wed, Nov 21, 2012 at 06:41:06PM +0530, Philip, Avinash wrote:
> > Add PWMSS device tree nodes in relation with ECAP & EHRPWM DT nodes to
> > AM33XX SoC family. Also populates device tree nodes for ECAP & EHRPWM by
> > adding necessary properties like pwm-cells, base reg & set disabled as
> > status.
> > 
> > Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> > ---
> > Changes since v2:
> > 	- ranges property populated to handle child devices address range
> > 
> > :100644 100644 20a3f29... 4393161... M	arch/arm/boot/dts/am33xx.dtsi
> >  arch/arm/boot/dts/am33xx.dtsi |   84 +++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 84 insertions(+), 0 deletions(-)
> 
> Looks good to me,

Thanks
Avinash

> 
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
> 
