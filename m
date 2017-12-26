From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Dec 2017 16:33:13 +0800
Subject: [PATCH] ARM: imx: remove unused imx3 pm definitions
In-Reply-To: <1513678024-2779-1-git-send-email-martin@kaiser.cx>
References: <1513678024-2779-1-git-send-email-martin@kaiser.cx>
Message-ID: <20171226083312.GH23070@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 11:07:04AM +0100, Martin Kaiser wrote:
> Remove the defintion of mx3_cpu_lp_set(), this function is not
> implemented anywhere. Remove then mx3_cpu_pwr_mode enum as well,
> it was used only as parameter of mx3_cpu_lp_set().
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Applied, thanks.
