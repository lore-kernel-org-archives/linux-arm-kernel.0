From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Dec 2011 10:37:17 +0900
Subject: [PATCH 00/12] ARM: restart: SAMSUNG: use new restart hook
In-Reply-To: <20111220210022.GC2577@n2100.arm.linux.org.uk>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
 <20111220210022.GC2577@n2100.arm.linux.org.uk>
Message-ID: <05db01ccbf81$130d58f0$39280ad0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Tue, Dec 20, 2011 at 09:48:24PM +0900, Kukjin Kim wrote:
> > This patch introduces common.[ch] in each SAMSUNG mach- directories
> > and implements using new restart hook for Samsung stuff.
> >
> > This is against on rmk/devel-stable branch.
> >
> > [PATCH 01/12] ARM: S3C64XX: introduce arch/arm/mach-s3c64xx/common.[ch]
> > [PATCH 02/12] ARM: restart: S3C64XX: use new restart hook
> > [PATCH 03/12] ARM: S5P64X0: introduce arch/arm/mach-s5p64x0/common.[ch]
> > [PATCH 04/12] ARM: restart: S5P64X0: use new restart hook
> > [PATCH 05/12] ARM: S5PC100: introduce arch/arm/mach-s5pc100/common.[ch]
> > [PATCH 06/12] ARM: restart: S5PC100: use new restart hook
> > [PATCH 07/12] ARM: S5PV210: introduce arch/arm/mach-s5pv210/common.[ch]
> > [PATCH 08/12] ARM: restart: S5PV210: use new restart hook
> > [PATCH 09/12] ARM: EXYNOS: introduce arch/arm/mach-exynos/common.[ch]
> > [PATCH 10/12] ARM: restart: EXYNOS: use new restart hook
> > [PATCH 11/12] ARM: restart: S3C24XX: move SWRST based S3C platforms
> > [PATCH 12/12] ARM: restart: S3C24XX: use new restart hook
> 
> I think this series looks fine - I'd like the cleanups to be ordered
> before
> any of the other changes (so that the cleanups can be applied to the
> restart-cleanup branch and queued into devel-stable independently of the
> rest of the restart changes.)
> 
OK, let me re-ordered like following.

[PATCH 01/12] ARM: S3C64XX: introduce arch/arm/mach-s3c64xx/common.[ch]
[PATCH 03/12] ARM: S5P64X0: introduce arch/arm/mach-s5p64x0/common.[ch]
[PATCH 05/12] ARM: S5PC100: introduce arch/arm/mach-s5pc100/common.[ch]
[PATCH 07/12] ARM: S5PV210: introduce arch/arm/mach-s5pv210/common.[ch]
[PATCH 09/12] ARM: EXYNOS: introduce arch/arm/mach-exynos/common.[ch]

[PATCH 04/12] ARM: restart: S5P64X0: use new restart hook
[PATCH 06/12] ARM: restart: S5PC100: use new restart hook
[PATCH 08/12] ARM: restart: S5PV210: use new restart hook
[PATCH 10/12] ARM: restart: EXYNOS: use new restart hook
[PATCH 11/12] ARM: restart: S3C24XX: move SWRST based S3C platforms
[PATCH 12/12] ARM: restart: S3C24XX: use new restart hook
[PATCH 02/12] ARM: restart: S3C64XX: use new restart hook

> Please submit them to the patch system in a couple of days time (to give
> some time for anyone to ack them.)
> 
OK, this will be submitted to patch system on FRI and as a note, there were
mis-deleting so I fixed it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
