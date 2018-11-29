From: jrdr.linux@gmail.com (Souptick Joarder)
Date: Thu, 29 Nov 2018 11:34:34 +0530
Subject: [PATCH 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
In-Reply-To: <5480157.mmjlM7ZeET@diego>
References: <20181115154826.GA27948@jordon-HP-15-Notebook-PC>
 <CAFqt6zZy0-dy=a+KDrx7V1-j37pAVmt2r6bOkjgHwiopG-L+xA@mail.gmail.com>
 <5480157.mmjlM7ZeET@diego>
Message-ID: <CAFqt6zbqjFa-zS7TLx3Tcr3nvsdrbxsrOswWoh5xb_SoxPn98A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 8:49 PM Heiko St?bner <heiko@sntech.de> wrote:
>
> Hi Souptick,
>
> Am Montag, 26. November 2018, 06:36:42 CET schrieb Souptick Joarder:
> > On Thu, Nov 15, 2018 at 9:14 PM Souptick Joarder <jrdr.linux@gmail.com>
> wrote:
> > > Convert to use vm_insert_range() to map range of kernel
> > > memory to user vma.
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >
> > Any feedback for this patch ?
>
> sorry, took a bit longer to find time for a test-run.
>
> Except the missing EXPORT_SYMBOL already pointed out in patch1,
> my displays are still working on modern (with iommu) and the older
> (without iommu) Rockchip socs, so
>
> On rk3188, rk3288, rk3328 and rk3399
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> and in general
> Acked-by: Heiko Stuebner <heiko@sntech.de>

Thanks Heiko.
>
>
> Heiko
>
>
