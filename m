From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 06 May 2014 20:08:47 +0200
Subject: [PATCH v12 00/31] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
In-Reply-To: <20140506175904.GB12376@8bytes.org>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <26065037.GxQQuIURPg@wuerfel>
 <CAOD6ATqZ5UwRwSKiPDQLrgmX=UUrJVE7ybM_RhXz_CEUjM3W7w@mail.gmail.com>
 <20140506175904.GB12376@8bytes.org>
Message-ID: <5369252F.4070402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.05.2014 19:59, Joerg Roedel wrote:
> On Wed, Apr 30, 2014 at 04:27:10PM +0530, Shaik Ameer Basha wrote:
>> This series is going on for quite a long time and most of the patches here
>> doesn't depend on dt bindings. As Exynos IOMMU h/w is introducing new versions
>> very frequently, maintaining and reviewing all these patches again and
>> again is quite a hard job.
>>
>> If it is acceptable, I can post one more series with the subset of
>> above patches,
>> which doesn't depend on dt-bindings. As all the patches which doesn't depend on
>> DT bindings are already tested,  I hope merging these subset of patches may help
>> in reducing the rework and review effort every time.
>>
>> Once we finalize the generic DT bindings for the IOMMU devices, the driver
>> can be updated with the proposed DT bindings in mind.
>
> Sounds reasonable to me if the patch subset is self-contained. When
> Arnd is OK with that and no one else has objections I can take the
> dt-independend parts.

+1.

I would also suggest dropping patch 18/31, for the reasons I mentioned 
in my reply to it.

Best regards,
Tomasz
