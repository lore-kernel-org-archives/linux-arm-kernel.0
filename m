From: santosh.shilimkar@ti.com (Santosh)
Date: Wed, 14 Sep 2011 11:43:26 +0530
Subject: [PATCH] ARM: EXYNOS4: Enable double linefill in PL310 Prefetch
	Control Register
In-Reply-To: <CAH9JG2VFSwL7hCmGpHXx_UKKwK3dbhNRGQB1bwvcD-YC1Qj-AQ@mail.gmail.com>
References: <1315894031-9579-1-git-send-email-siarhei.siamashka@gmail.com>
	<CAH9JG2VFSwL7hCmGpHXx_UKKwK3dbhNRGQB1bwvcD-YC1Qj-AQ@mail.gmail.com>
Message-ID: <4E704606.6040606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 September 2011 11:38 AM, Kyungmin Park wrote:
> Hi Siarhei,
>
> Interesting feature, and it's not samsung soc issue, so add the arm
> mailing list.
> It checked and the see the read performance improvement from 868MiB/s
> to 981MiB/s with lmbench.
> It's helpful to test other SoC., e.g., OMAP4, STE and so on.
>
> BTW, why do you set the 27-bit? In my PL310 Spec., it's reserved bit
> and should be zero (SBZ).
>
That's because not all PL310 versions double line fill.

Regards
santosh
