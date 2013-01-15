From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Jan 2013 11:59:43 -0700
Subject: [PATCH v2 3/3 RFT] ARM: tegra: dts: seaboard: enable keyboard
In-Reply-To: <1358234689-18126-1-git-send-email-ldewangan@nvidia.com>
References: <1358234689-18126-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <50F5A71F.7010108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2013 12:24 AM, Laxman Dewangan wrote:
> Enable tegra based keyboard controller and populate the key matrix for
> seaboard. The key matrix was originally on driver code which is removed
> to have clean driver. The key mapping is now passed through dts file.

Applied to Tegra's for-3.9/dt branch.
