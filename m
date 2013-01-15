From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Jan 2013 11:59:08 -0700
Subject: [PATCH 1/3] ARM: DT: tegra: add DT entry for KBC controller
In-Reply-To: <1357911185-11048-1-git-send-email-ldewangan@nvidia.com>
References: <1357911185-11048-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <50F5A6FC.4090104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2013 06:33 AM, Laxman Dewangan wrote:
> NVIDIA's Tegra SoCs have the matrix keyboard controller which
> supports 16x8 type of matrix. The number of rows and columns
> are configurable.
> 
> Add DT entry for KBC controller.

Applied to Tegra's for-3.9/dt branch.

I added the required clocks property for this patch to work with
Prashant's common clock framework port, although it's commented out so
far, until the CCF rework is actually applied.
