From: avinashphilip@ti.com (Philip, Avinash)
Date: Fri, 23 Nov 2012 10:35:02 +0000
Subject: [PATCH v4 11/11] ARM: dts: AM33XX: Add PWM backlight DT data to
 am335x-evmsk
In-Reply-To: <20121122211245.GJ16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-12-git-send-email-avinashphilip@ti.com>
 <20121122211245.GJ16716@avionic-0098.adnet.avionic-design.de>
Message-ID: <518397C60809E147AF5323E0420B992E3E9EE9B3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 02:42:45, Thierry Reding wrote:
> On Wed, Nov 21, 2012 at 06:41:08PM +0530, Philip, Avinash wrote:
> > PWM output from ecap2 uses as backlight source. Also adds low threshold
> > value to have a uniform divisions in brightness-levels scales with
> > inverse polarity.
> > 
> > Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> > ---
> > :100644 100644 f5a6162... 6f3de83... M	arch/arm/boot/dts/am335x-evmsk.dts
> >  arch/arm/boot/dts/am335x-evmsk.dts |   23 +++++++++++++++++++++++
> >  1 files changed, 23 insertions(+), 0 deletions(-)
> 
> Same comments as for the previous patch, but otherwise:

I will correct it

Thanks
Avinash
> 
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
> 
