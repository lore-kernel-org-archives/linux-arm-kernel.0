From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Mar 2013 14:29:43 -0700
Subject: [PATCH 1/3] ARM: tegra: Fix unchecked return value
In-Reply-To: <1361514267-12111-1-git-send-email-josephl@nvidia.com>
References: <1361514267-12111-1-git-send-email-josephl@nvidia.com>
Message-ID: <5137B547.4040904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2013 11:24 PM, Joseph Lo wrote:
> Check a return value for tegra_powergate_remove_clamping().

I have applied patches 1/3 and 2/3 to Tegra's for-3.10/fixes, and 3/3 to
Tegra's for-3.10/cleanup branches.
