From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 01 Jun 2012 16:22:13 +0400
Subject: [PATCH 1/9] ARM: tegra: add clk_prepare/clk_unprepare
In-Reply-To: <1338541968-7961-2-git-send-email-pgaikwad@nvidia.com>
References: <1338541968-7961-1-git-send-email-pgaikwad@nvidia.com>
 <1338541968-7961-2-git-send-email-pgaikwad@nvidia.com>
Message-ID: <4FC8B3F5.5@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-06-2012 13:12, Prashant Gaikwad wrote:

> Use clk_prepare/clk_unprepare as required by the generic clk framework.

> This patch should go through Tegra tree since other patches to port Tegra
> to generic clock framework are dependent on it. Posting here to get ack from
> the maintainers.

    This paragraph should have followed the --- tear line; likewise in all the 
other patches. It's not fit for the patch description.

> Tested on Ventana and Cardhu.

> Signed-off-by: Prashant Gaikwad<pgaikwad@nvidia.com>

WBR, Sergei
