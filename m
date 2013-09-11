From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 11 Sep 2013 13:19:28 -0600
Subject: [PATCH 1/2] cpufreq: tegra: Remove not used header and clean
 up codes
In-Reply-To: <1378898355-31290-2-git-send-email-bilhuang@nvidia.com>
References: <1378898355-31290-1-git-send-email-bilhuang@nvidia.com>
 <1378898355-31290-2-git-send-email-bilhuang@nvidia.com>
Message-ID: <5230C240.8050602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2013 05:19 AM, Bill Huang wrote:
> Remove inclustion of the not needed header files and remove the logic
> to check the CPU ID to not exceeding the maximum supported CPUs.

> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c

> - * Copyright (C) 2010 Google, Inc.
> + * Copyright (c) 2013, NVIDIA Corporation.
> + * Copyright (C) 2010-2013 Google, Inc.

This is such a trivial patch, I don't think it's appropriate to add an
NVIDIA (c) notice. It may well be appropriate in patch 2/2.

I assume that Google didn't write this patch, so why adjust that (c) notice?
