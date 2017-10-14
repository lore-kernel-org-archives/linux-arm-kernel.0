From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 14 Oct 2017 23:05:05 +0800
Subject: [PATCH v2] ARM: imx: Enable cpuidle for i.MX6DL starting at 1.1
In-Reply-To: <800ef25ed868f303bb2aece5dba59d395340f25d.1507722933.git.leonard.crestez@nxp.com>
References: <800ef25ed868f303bb2aece5dba59d395340f25d.1507722933.git.leonard.crestez@nxp.com>
Message-ID: <20171014150503.GO8833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 03:08:23PM +0300, Leonard Crestez wrote:
> Enable cpuidle support on i.MX6DL starting from IMX_CHIP_REVISION_1_1.
> 
> This also makes the code cleaner because 6q and 6dl actually have
> different revision histories.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
