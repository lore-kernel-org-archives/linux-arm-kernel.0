From: andi.shyti@samsung.com (Andi Shyti)
Date: Mon, 06 Mar 2017 13:50:25 +0900
Subject: [PATCH v4 5/5] arm: dts: Remove the OF graph from DSI node
In-Reply-To: <1488775343-6236-6-git-send-email-hoegeun.kwon@samsung.com>
References: <1488775343-6236-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170306044239epcas1p2cf8ad82b218e72119af0a35af249148f@epcas1p2.samsung.com>
 <1488775343-6236-6-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170306045025.rvjsxwza5djydpho@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoegeun,

On Mon, Mar 06, 2017 at 01:42:23PM +0900, Hoegeun Kwon wrote:
> The OF graph is not needed because the panel is a child of dsi. Remove
> the ports node in DSI node, and port node in panel node.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Andi
