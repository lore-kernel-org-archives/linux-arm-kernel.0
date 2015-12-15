From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 15 Dec 2015 10:23:07 +0100
Subject: [PATCHv2 1/2] ARM: multi_v7_defconfig: Enable Rockchip generic
 power domain.
In-Reply-To: <CAFqH_51TXmOaf2KQrtTv3uuFvL4vZ5nNRSzfE_NQmbQ75TdAWw@mail.gmail.com>
References: <1450167651-5703-1-git-send-email-enric.balletbo@collabora.com>
 <CAFqH_51TXmOaf2KQrtTv3uuFvL4vZ5nNRSzfE_NQmbQ75TdAWw@mail.gmail.com>
Message-ID: <1979197.BQ9gqTIVFm@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric,

Am Dienstag, 15. Dezember 2015, 09:25:34 schrieb Enric Balletbo Serra:
> Arght, I'm asleep, I need a coffee this now, there isn't patch 2/2,
> this patch is 1/1.

I do think you can limit the recipients to "arm at kernel.org", the mailing lists 
and me (and include linux-rockchip at lists.infradead.org as well). I don't think 
your other recipients will care to much about Rockchip-specific defconfig 
changes ;-) .

Also, please keep author mail addresses in line ... The address used in the 
signed-off-by should also be the one the patch gets sent from. 

Alternatively it is also possible to override the From, when patch author-mail 
and sending address differ. git send-email does this automatically, but it's 
also possible to do manually (see patches with "From: ..." + blank line at the 
top of the content).


Heiko

> 
> 
> Sorry for the noise.
> Enric
> 
> 2015-12-15 9:20 GMT+01:00 Enric Balletbo i Serra <eballetbo@gmail.com>:
> > In order to meet high performance an low power requirement for Rockchip
> > enable the power domain support. The patch also fixes a drm/kms issue,
> > driver deferring untils power-domains are available)
> > 
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> > Changes since last version:
> >  - Add justification as proposed by Heiko
> >  - Add to=arm at kernel.org
> >  
> >  arch/arm/configs/multi_v7_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/multi_v7_defconfig
> > b/arch/arm/configs/multi_v7_defconfig index 69a22fd..81314ec 100644
> > --- a/arch/arm/configs/multi_v7_defconfig
> > +++ b/arch/arm/configs/multi_v7_defconfig
> > @@ -655,6 +655,7 @@ CONFIG_QCOM_PM=y
> > 
> >  CONFIG_QCOM_SMD=y
> >  CONFIG_QCOM_SMD_RPM=y
> >  CONFIG_QCOM_SMEM=y
> > 
> > +CONFIG_ROCKCHIP_PM_DOMAINS=y
> > 
> >  CONFIG_COMMON_CLK_QCOM=y
> >  CONFIG_CHROME_PLATFORMS=y
> >  CONFIG_CROS_EC_CHARDEV=m
> > 
> > --
> > 2.1.0
