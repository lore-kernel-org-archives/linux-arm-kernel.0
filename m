From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 07 Feb 2014 14:49:53 +0100
Subject: [PATCH] iommu/exynos: Remove driver
In-Reply-To: <CAH9JG2Xoz1_Y7CV6FUiGAO9o5T7jtFUYqJpcAysLttwu4527zQ@mail.gmail.com>
References: <1391716317-20300-1-git-send-email-olof@lixom.net>
 <CAAQKjZMo6=dtur6NfvDY9=jVF=7VxHub=isnEwPw0+RKCq6xAg@mail.gmail.com>
 <CAH9JG2Xoz1_Y7CV6FUiGAO9o5T7jtFUYqJpcAysLttwu4527zQ@mail.gmail.com>
Message-ID: <52F4E481.3050902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-02-07 13:44, Kyungmin Park wrote:
>
> On Friday, February 7, 2014, Inki Dae <inki.dae@samsung.com 
> <mailto:inki.dae@samsung.com>> wrote:
>
>     2014-02-07 Olof Johansson <olof@lixom.net <javascript:;>>:
>     > The driver has been unbuildable due to unfulfilled dependencies
>     since
>     > 3.11, and even if enabled it won't build due to build breakage.
>     Emails
>     > about status on this have gone unanswered, and fixes seem to
>     have been
>     > abandoned.
>     >
>     > It's obvious that nobody cares about it, so let's remove it.
>
>     Wait, we are going to fix up this module. It seems that KyoungHo,
>     original author, is busy with some works related to product.
>
>     we can care about it if KyoungHo cannot afford to care for the
>     time being.
>
> Any volunteers?
> Marek or Bartek, how do you think?
>
> Before that it makes orphan or unsupported at maintainer file first and
> change it to new volunteers.

I think that it might be easier to remove the existing non-functional driver
now and add it again once the driver is ready. I have it on my TODO 
list, but
doubt I will manage to finish it for v3.15.

Discussing the DT bindings might take some time.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
