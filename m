From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Feb 2014 11:45:26 -0700
Subject: [PATCH v3 6/6] ARM: tegra: remove fuse files from mach-tegra
In-Reply-To: <1390952176-30402-7-git-send-email-pdeschrijver@nvidia.com>
References: <1390952176-30402-1-git-send-email-pdeschrijver@nvidia.com>
 <1390952176-30402-7-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52F286C6.1030903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 04:36 PM, Peter De Schrijver wrote:
> All fuse related functionality is now provided by the tegra fuse driver.
> Hence all the fuse related files in mach-tegra can be removed.

It's probably worth squashing this into patch 5, since that's what makes
these files unused.
