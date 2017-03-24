From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 24 Mar 2017 13:49:27 +0800
Subject: [PATCH v2 0/8] soc: imx: gpc: fixes and clean up
In-Reply-To: <1490244805-3921-1-git-send-email-aisheng.dong@nxp.com>
References: <1490244805-3921-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170324054925.GG30608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 12:53:17PM +0800, Dong Aisheng wrote:
> Dong Aisheng (8):
>   soc: imx: gpc: fix gpc clk get error handling
>   soc: imx: gpc: fix the wrong using of regmap cache
>   soc: imx: gpc: fix domain_index sanity check issue
>   soc: imx: gpc: fix imx6sl gpc power domain regression
>   soc: imx: gpc: fix comment when power up domain
>   soc: imx: gpc: keep PGC_X_CTRL name align with reference manual
>   dt-bindings: imx-gpc: correct the DOMAIN_INDEX using
>   soc: imx: gpc: remove unnecessary readable_reg callback

Applied all, thanks.
