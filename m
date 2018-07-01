From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 1 Jul 2018 16:51:13 +0800
Subject: [PATCH] ARM: imx: enable bus auto clock gating function for
 i.mx6sll
In-Reply-To: <1529645568-3786-1-git-send-email-Anson.Huang@nxp.com>
References: <1529645568-3786-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180701085111.GK4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 01:32:48PM +0800, Anson Huang wrote:
> i.MX6SLL has HW bus auto clock gating function, enable
> it by default to save VDD_SOC_IN power, about 5% ~ 20%
> saved depends on different use cases.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
