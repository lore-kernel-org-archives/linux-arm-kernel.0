From: andi.shyti@samsung.com (Andi Shyti)
Date: Mon, 06 Mar 2017 13:49:12 +0900
Subject: [PATCH v4 1/5] arm64: dts: exynos: Add the burst and esc clock
 frequency properties to DSI node
In-Reply-To: <1488775343-6236-2-git-send-email-hoegeun.kwon@samsung.com>
References: <1488775343-6236-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170306044233epcas1p20b5e6c764a7752290e5ed25cc13a69af@epcas1p2.samsung.com>
 <1488775343-6236-2-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170306044912.b7syhwilwxygpjlj@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoegeun,

On Mon, Mar 06, 2017 at 01:42:19PM +0900, Hoegeun Kwon wrote:
> The OF graph is not needed because the panel is a child of dsi. Add
> the burst and esc clock frequency properties to the parent (DSI node).
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

you forgot to put me in Cc and add my

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Andi
