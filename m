From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 10 Oct 2011 16:00:48 +0200
Subject: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
In-Reply-To: <CAHQjnOOhtSiivWf34S8mjB9nqQfUwadLzE8zOm4jYvsgL_d+Wg@mail.gmail.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
	<1316195506-9777-2-git-send-email-ohad@wizery.com>
	<20110927100505.GH2138@amd.com>
	<CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
	<20110927131222.GL2138@amd.com>
	<CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
	<20110927181438.GM2138@amd.com>
	<CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
	<CAHQjnOOhtSiivWf34S8mjB9nqQfUwadLzE8zOm4jYvsgL_d+Wg@mail.gmail.com>
Message-ID: <CAK=WgbbzPmdtH9J2H0-jh+NipJ+GenEkkqorMLZpPU+xmZ3C4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 2:52 PM, KyongHo Cho <pullip.cho@samsung.com> wrote:
> Do not we need to unmap all intermediate mappings if iommu_map() is failed?

Good idea, I'll add it.

Thanks!
Ohad.
