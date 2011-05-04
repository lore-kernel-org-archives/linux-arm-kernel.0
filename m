From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Wed, 4 May 2011 11:07:21 +0900
Subject: [PATCH] ARM: EXYNOS4: Bugfix Hotplug
In-Reply-To: <1304470284-25770-1-git-send-email-myungjoo.ham@samsung.com>
References: <1304470284-25770-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <BANLkTinsfxW+4Xp5_dgY0b3w291ya86vJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2011 at 9:51 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> When tested with "NURI" board, Exynos4 has not been working
> properly and showed error messages when the secondary core is being
> enabled with hotplug. The NURI board has Exynos4 of revision 1.
>
> This patch enables Exynos4's hotplug to work properly.
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Sorry, but it requires further modifications at platsmp.c to run
hotplug in Exynos4 without another issue and I've missed that file in
this patch.

I'll submit it as soon as the patch is cleaned up.

-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
