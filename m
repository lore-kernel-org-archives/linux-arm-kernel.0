From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 07 Oct 2013 11:19:55 -0600
Subject: [PATCH 3/7] ARM: tegra: add SMP support for Tegra124
In-Reply-To: <1381131085-26116-4-git-send-email-josephl@nvidia.com>
References: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
 <1381131085-26116-4-git-send-email-josephl@nvidia.com>
Message-ID: <5252ED3B.9060808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 01:31 AM, Joseph Lo wrote:
> The power up method is same as Tegra114, so we share the same function
> for it.

These first 3 patches are all small, related, and all to the same code
in arch/arm/mach-tegra/, so they could just be squashed into a single patch.
