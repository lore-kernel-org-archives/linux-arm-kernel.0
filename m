From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Jun 2011 11:33:41 -0700
Subject: [PATCH 0/9] Add clkdev support for Samsung platforms
In-Reply-To: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
References: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <4DF11205.7040103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/11 21:38, Thomas Abraham wrote:
> This patch series adds clkdev support for all Samsung platforms. clkdev
> support is a prerequisite for adding device tree on Samsung platforms
> and possibly revive framebuffer driver patches for Exynos4 platforms.
>
> The first of the two patches are for eliminating the explict
> console_initcall from the serial drivers. This is required to prevent
> the clk_get being invoked at time when device registrations have not
> completed.
>
> This patch series is based on the latest
> git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next
>
> and the patch "[PATCH] Consolidate the clkdev header files".
>
> It has been tested on the following boards.
>
> SMDK2416, SMDK2440, SMDK2450, SMDK6410, SMDK6440, SMDK6450,
> SMDKC100, SMDKV210 and SMDKV310.
>

Thomas,

Basically, this is good to me. I will check again after backing to
my office and will apply whole series :)

If any problems, let you know.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
