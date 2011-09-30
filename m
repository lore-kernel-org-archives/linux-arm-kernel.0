From: pullip.cho@samsung.com (KyongHo Cho)
Date: Sat, 1 Oct 2011 08:52:45 +0900
Subject: [PATCH v2 5/5] iommu/exynos: Use bus_set_iommu instead of
	register_iommu
In-Reply-To: <20110930134643.GS2138@amd.com>
References: <017001cc7f43$04a2db60$0de89220$%kim@samsung.com>
	<20110930134643.GS2138@amd.com>
Message-ID: <CAHQjnOPiAOA_RiHnF-aVEYnWcdkwNzVD1BTNua+-ztZrW_+6_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 10:46 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> On Fri, Sep 30, 2011 at 03:31:49AM -0400, Kukjin Kim wrote:
>> From: KyongHo Cho <pullip.cho@samsung.com>
>>
>> This replaces register_iommu() with bus_set_iommu() according to the
>> suggestion of Joerg Roedel.
>
> This should be part of patch 3 already when the bus_set_iommu() change
> is merged. Otherwise it breaks bisectability too.
>
Ok.
Should I include fault handling feature (patch 4) in the patch 3 also?

Thanks.
KyongHo.
