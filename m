From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 08 Nov 2014 18:46:43 +0900
Subject: [PATCH v2 1/1] ARM: exynos_defconfig: Enable options for display
 panel support
In-Reply-To: <CABxcv=m-aNVcUU2C8LosCECxq1yZo2C3zfA2xe6z7jF8tFPsnw@mail.gmail.com>
References: <1408956336-17376-1-git-send-email-javier.martinez@collabora.co.uk>
 <CABxcv=m-aNVcUU2C8LosCECxq1yZo2C3zfA2xe6z7jF8tFPsnw@mail.gmail.com>
Message-ID: <000d01cffb38$e90e42c0$bb2ac840$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:
> 
> Hello Kukjin,
> 
Hi,

> On Mon, Aug 25, 2014 at 10:45 AM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
> > Many Exynos devices have a display panel. Most of them just have
> > a simple panel while others have more complex configurations that
> > requires an embedded DisplayPort (eDP) to LVDS bridges.
> >
> > This patch enables the following features to be built in the kernel
> > image to suport both setups:
> >
> > - Direct Rendering Manager (DRM)
> > - DRM bridge registration and lookup framework
> > - Parade ps8622/ps8625 eDP/LVDS bridge
> > - NXP ptn3460 eDP/LVDS bridge
> > - Exynos Fully Interactive Mobile Display controller (FIMD)
> > - Panel registration and lookup framework
> > - Simple panels
> > - Backlight & LCD device support
> >
> > Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > Tested-by: Kevin Hilman <khilman@linaro.org>
> > ---
> 
> This patch is needed to have display working on many Exynos boards.
> 
OK, I'll apply this into samsung tree in this weekend.

Thanks for your gentle reminder.

- Kukjin

> $subject enables the config option for the ps8622/ps8625 eDP/LVDS
> bridge driver but this has not landed in mainline yet. Ajay will
> re-spin a new revision of his series that adds this driver though,
> after addressing some issues pointed out on a previous version.
> 
> The Kconfig symbol name (DRM_PS8622) won't change though so maybe is
> not crazy to pick the patch as is since CONFIG_DRM_PS8622 will have to
> be enabled later when the bridge driver lands. Or do you want me to
> re-spin $subject removing that option?
> 
> Best regards,
> Javier
