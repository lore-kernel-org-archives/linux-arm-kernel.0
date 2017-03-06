From: andi.shyti@samsung.com (Andi Shyti)
Date: Mon, 06 Mar 2017 13:50:08 +0900
Subject: [PATCH v4 4/5] arm64: dts: exynos: Remove the OF graph from DSI
 node
In-Reply-To: <1488775343-6236-5-git-send-email-hoegeun.kwon@samsung.com>
References: <1488775343-6236-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170306044237epcas5p35d955ba5e849a8ebcf13007ab1b377dc@epcas5p3.samsung.com>
 <1488775343-6236-5-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170306045008.invhb36x5igmszrm@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoegeun,

On Mon, Mar 06, 2017 at 01:42:22PM +0900, Hoegeun Kwon wrote:
> The OF graph is not needed because the panel is a child of dsi. Remove
> the ports node in DSI node.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Andi
