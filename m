From: andi.shyti@samsung.com (Andi Shyti)
Date: Mon, 06 Mar 2017 13:49:52 +0900
Subject: [PATCH v4 3/5] drm/exynos: dsi: Fix the parse_dt function
In-Reply-To: <1488775343-6236-4-git-send-email-hoegeun.kwon@samsung.com>
References: <1488775343-6236-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170306044236epcas5p326440b0139bee5a33fd6545d0400bb57@epcas5p3.samsung.com>
 <1488775343-6236-4-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170306044952.qi32osytl4ynoooy@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoegeun,

On Mon, Mar 06, 2017 at 01:42:21PM +0900, Hoegeun Kwon wrote:
> The dsi + panel is a parental relationship, so OF grpah is not needed.
> Therefore, the current dsi_parse_dt function will throw an error,
> because there is no linked OF graph for case such as fimd + dsi +
> panel. So this patch parse the Pll, burst and esc clock frequency
> properties in dsi_parse_dt and modified to create a bridge_node only
> if there is an OF graph associated with dsi.
> So I think the ABI breakage is needed.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Andi
