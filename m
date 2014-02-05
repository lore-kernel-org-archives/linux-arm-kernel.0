From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Feb 2014 10:18:11 -0700
Subject: [PATCH] ARM: config: enable ams AS3722 power reset driver
In-Reply-To: <1389084000-17033-1-git-send-email-ldewangan@nvidia.com>
References: <1389084000-17033-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <52F27253.7070307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2014 01:39 AM, Laxman Dewangan wrote:
> ams AS3722 is used as system PMIC for Tegra124 based Venice2.
> Enable ams AS3722 power reset driver for enabling power off
> system using PMIC.

Applied to Tegra's for-3.15/defconfig branch.
