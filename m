From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 28 Nov 2018 16:19:41 +0100
Subject: [PATCH 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
In-Reply-To: <CAFqt6zZy0-dy=a+KDrx7V1-j37pAVmt2r6bOkjgHwiopG-L+xA@mail.gmail.com>
References: <20181115154826.GA27948@jordon-HP-15-Notebook-PC>
 <CAFqt6zZy0-dy=a+KDrx7V1-j37pAVmt2r6bOkjgHwiopG-L+xA@mail.gmail.com>
Message-ID: <5480157.mmjlM7ZeET@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Souptick,

Am Montag, 26. November 2018, 06:36:42 CET schrieb Souptick Joarder:
> On Thu, Nov 15, 2018 at 9:14 PM Souptick Joarder <jrdr.linux@gmail.com> 
wrote:
> > Convert to use vm_insert_range() to map range of kernel
> > memory to user vma.
> > 
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> 
> Any feedback for this patch ?

sorry, took a bit longer to find time for a test-run.

Except the missing EXPORT_SYMBOL already pointed out in patch1,
my displays are still working on modern (with iommu) and the older
(without iommu) Rockchip socs, so

On rk3188, rk3288, rk3328 and rk3399
Tested-by: Heiko Stuebner <heiko@sntech.de>
and in general
Acked-by: Heiko Stuebner <heiko@sntech.de>


Heiko
