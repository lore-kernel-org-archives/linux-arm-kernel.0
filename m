From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Sep 2012 12:24:23 -0600
Subject: [PATCH 1/2] ARM: tegra: fix return value for debugfs init
In-Reply-To: <1346943329-4898-1-git-send-email-pdeschrijver@nvidia.com>
References: <1346943329-4898-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <5048EA57.20308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 08:55 AM, Peter De Schrijver wrote:
> tegra_powergate_debugfs_init() always returns -ENOMEM. It shouldn't do that
> when registering the debugfs entry succeeded.

Thanks, applied the series to Tegra's for-3.7/fixes branch.
