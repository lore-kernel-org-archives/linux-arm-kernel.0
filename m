From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 11 Oct 2011 19:04:01 +0200
Subject: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
In-Reply-To: <CAHQjnOPcetkp-XX0x4HQsR+iYN1SaCAhuBEE2nVTdhssFpUmJQ@mail.gmail.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
	<1316195506-9777-2-git-send-email-ohad@wizery.com>
	<20110927100505.GH2138@amd.com>
	<CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
	<20110927131222.GL2138@amd.com>
	<CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
	<20110927181438.GM2138@amd.com>
	<CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
	<20111010094738.GW2138@amd.com>
	<CAK=WgbZ7Wyax1yfS1jSXw9OdwMtxxidwLO8PTsNUXX9CWzmVrw@mail.gmail.com>
	<20111010153609.GB2138@amd.com>
	<CAK=WgbbnuO67X46sqS87q2vw2TWq3Ekvw5p1PmXvXinQXMyowg@mail.gmail.com>
	<CAHQjnOPcetkp-XX0x4HQsR+iYN1SaCAhuBEE2nVTdhssFpUmJQ@mail.gmail.com>
Message-ID: <CAK=WgbZeZhr1AN82e1yab-rLWyB0tuK-s3wM+YoeJ24rsoXk2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi KyongHo,

On Tue, Oct 11, 2011 at 4:59 PM, KyongHo Cho <pullip.cho@samsung.com> wrote:
> I think the type of size should be size_t.
..
> Thus, it should be
> iommu_unmap(domain, orig_iova, orig_size - size)

Agree with both suggestions, thanks !

P.S - please only keep the parts of my email which you are replying
to, otherwise it's a bit hard to find your comments.

Thanks,
Ohad.
