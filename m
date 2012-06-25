From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Jun 2012 12:31:56 -0600
Subject: [PATCH] ARM: tegra: Remove second instance of uart clk
In-Reply-To: <1340610908-2729-1-git-send-email-pgaikwad@nvidia.com>
References: <1340610908-2729-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <4FE8AE9C.5000109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2012 01:55 AM, Prashant Gaikwad wrote:
> In Tegra30 clock file two clk objects were created for same UART clock.
> Remove the duplicates and add clock aliases instead.
> 
> Update the Tegra20 clock file to make the names consistent.

Thanks, applied to Tegra's for-3.6/common-clk since I assume your common
clock work will depend on this.
