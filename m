From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed, 19 Oct 2016 16:56:08 -0600
Subject: exynos-drm: display manager fails to start without IOMMU problem
In-Reply-To: <58079E16.50302@math.uni-bielefeld.de>
References: <CGME20160810214111epcas1p4dd2a581353b550a1992fc7695e846da7@epcas1p4.samsung.com>
 <1470850251-9150-1-git-send-email-shuahkh@osg.samsung.com>
 <57ABB1ED.1080301@samsung.com> <57ABB31E.1070802@osg.samsung.com>
 <57AE0736.6020705@osg.samsung.com> <57AE0CCB.1010708@osg.samsung.com>
 <57B29925.4020600@samsung.com>
 <ce7a035c-f881-82ac-97f6-869442d1ed47@osg.samsung.com>
 <1b2c3b31-7127-af2f-18a2-f3a28567e28d@osg.samsung.com>
 <2173cc13-7c77-1a38-501d-2c0f522ff5d5@osg.samsung.com>
 <58079E16.50302@math.uni-bielefeld.de>
Message-ID: <0a9b3996-38fb-e4f1-1e25-436f0f09f510@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2016 10:23 AM, Tobias Jakobi wrote:
> Hello Shuah,
> 
> just a short note that more misleading comments about default allocation
> flags can be found in libdrm.
> 
> https://cgit.freedesktop.org/mesa/drm/tree/exynos/exynos_drm.c
> 
> See e.g. the comment for exynos_bo_create().
> 
> In my opinion, the whole approach to _set_ a bit to get non-contigious
> memory is messed up. It would make more sense to me to set a bit to
> request an additional property (here "being contiguous") of the memory.
> 
> Anyway, clearing up this situation is highly appreciated!
> 
> More comments below.
> 
> With best wishes,
> Tobias
> 

Hi Tobias,

Thanks for the note. Yes the comments are confusing. It seems like
some old assumptions are persisting. I will fix these as well.

-- Shuah
