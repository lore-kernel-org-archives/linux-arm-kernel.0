From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 Jan 2013 12:07:05 -0700
Subject: [PATCH] ARM: tegra30: tegra30 gpio is not compatible with tegra20
 gpio
In-Reply-To: <1355929032-26549-1-git-send-email-ldewangan@nvidia.com>
References: <1355929032-26549-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <50E48559.9060007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2012 07:57 AM, Laxman Dewangan wrote:
> tegra30 gpio controller is not compatible with the tegra20 due to
> their bank stride i.e. Tegra20 bank stride is 0x80 where Tegra30
> bank stride is 0x100.

Applied to Tegra's for-3.9/dt branch.
