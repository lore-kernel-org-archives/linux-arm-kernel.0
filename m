From: pullip.cho@samsung.com (KyongHo Cho)
Date: Wed, 12 Oct 2011 18:18:51 +0900
Subject: [PATCH v4 2/2] iommu/exynos: Add iommu driver for Exynos Platforms
In-Reply-To: <CAK=WgbZ4RjJXjCXeN-rg84OLv1KZiWAAXXTWXknn_Gt4eioqDA@mail.gmail.com>
References: <000501cc88b6$0dd17d00$29747700$%cho@samsung.com>
	<CAK=WgbZ4RjJXjCXeN-rg84OLv1KZiWAAXXTWXknn_Gt4eioqDA@mail.gmail.com>
Message-ID: <CAHQjnONHt0U6-4VTVOg35q+MBWgBartt-nG8CYYcEb74RPcPTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On Wed, Oct 12, 2011 at 5:22 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> +static int exynos_iommu_unmap(struct iommu_domain *domain, unsigned long
>> iova,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ?int gfp_order)
>> +{
> ...
>> + ? ? ? return 0;
>> +}
>
> ->unmap() should return the size of the unmapped region (in page order
> atm); this is already expected by mainline users of the IOMMU API
> today, and will also be used by the iommu core itself soon.
>
Ok. Thank you. I missed that.

I will send new patches immediately

KyongHo.
