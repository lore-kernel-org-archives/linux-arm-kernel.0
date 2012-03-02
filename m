From: pullip.cho@samsung.com (KyongHo Cho)
Date: Fri, 2 Mar 2012 14:45:43 +0900
Subject: [PATCH v9 0/2] iommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <CAH9JG2Vg8o_mm0gM042T0-kjMUoAdLzF+DeGErD7R86H0xqXZQ@mail.gmail.com>
References: <001801ccf5e3$69d79860$3d86c920$%cho@samsung.com>
 <CAH9JG2Vg8o_mm0gM042T0-kjMUoAdLzF+DeGErD7R86H0xqXZQ@mail.gmail.com>
Message-ID: <CAHQjnONxO32WP40sJz80=rjv3kqxmx55MUvjvhhO_mo3DNH8-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 4:01 PM, Kyungmin Park
<kyungmin.park@samsung.com> wrote:
> Hi,
>
> Some comments.
> 1. It's not same patch series. since it has additional feature,
> exynos5 series support which don't covered at previous time.
> 2. It assumes that name conversion is based on exynos5 as default. now
> you use gsc at exynos4 even though there's no gsc block. It should be
> fimc.

Thanks. I agree about the second and applied it in the next patchset.

>
> So I suggest to send exynos4 series patch as before and send
> additional exynos5 patch series next.
>

I will just extract a new patch that removes existing system MMU driver from
the previous 2 patches and the patchset will consist of 3 patches.
