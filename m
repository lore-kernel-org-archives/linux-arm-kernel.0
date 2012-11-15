From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 Nov 2012 14:40:13 -0700
Subject: [PATCH V2 0/3] ARM: tegra: add speedo identification for T20/T30
In-Reply-To: <1352965354-650-1-git-send-email-dahuang@nvidia.com>
References: <1352965354-650-1-git-send-email-dahuang@nvidia.com>
Message-ID: <50A5613D.5080601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2012 12:42 AM, Danny Huang wrote:
> This patch series adds speedo identification functionality for tegra
> T20 and T30. It reads speedo value from fuse and chooses CPU and core 
> process ID by checking speedo corner tables.

I think this all looks fine; I assume there will be some forthcoming
usage of the new variables.

I applied the series with some very minor changes to the printfs and
commit description to that "Tegra20" was consistently used instead of
"T20" or "Tegra2", and the same for Tegra30.
