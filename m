From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Jan 2013 11:04:19 -0700
Subject: [v4 1/6] ARM: tegra: Use DT /cpu node to detect number of CPU core
In-Reply-To: <1359025829-22306-2-git-send-email-hdoyu@nvidia.com>
References: <1359025829-22306-1-git-send-email-hdoyu@nvidia.com>
 <1359025829-22306-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <5106BDA3.8090009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 04:10 AM, Hiroshi Doyu wrote:
> Tegra SoCs does not use SCU based to detect CPU core numbers but they
> use DT /cpu node. If it's not provided or failed, it continues as a
> single core.

I've applied patch 1 to Tegra's for-3.9/scu-base-rework branch, and
patches 2-6 to Tegra's for-3.9/soc-t114 branch.
