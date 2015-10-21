From: sowmini.varadhan@oracle.com (Sowmini Varadhan)
Date: Wed, 21 Oct 2015 15:56:40 -0400
Subject: [PATCH] iommu-common: fix return type of iommu_tbl_range_alloc()
In-Reply-To: <CAMuHMdXGM0ynDSv-_MdZptXeqJ=sU7=LChmihSCoqanVTUpWXQ@mail.gmail.com>
References: <55FBD36C.5070301@arm.com>
 <1442567375-6963-1-git-send-email-andre.przywara@arm.com>
 <CAMuHMdXGM0ynDSv-_MdZptXeqJ=sU7=LChmihSCoqanVTUpWXQ@mail.gmail.com>
Message-ID: <20151021195640.GC14667@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (10/21/15 21:12), Geert Uytterhoeven wrote:
> 
> Does this function really need to return DMA_ERROR_CODE in case of
> failure?

fwiw, this came up very early in code review:

  http://marc.info/?l=linux-sparc&m=142613044704833&w=2

--Sowmini
