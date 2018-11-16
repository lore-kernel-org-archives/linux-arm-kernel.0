From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Nov 2018 13:21:30 +0800
Subject: [PATCH] ARM: dts: imx6sll: remove unused property in gpc node
In-Reply-To: <1541495675-14706-1-git-send-email-Anson.Huang@nxp.com>
References: <1541495675-14706-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20181116052128.GL5829@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 09:19:36AM +0000, Anson Huang wrote:
> The "fsl,mf-mix-wakeup-irq" is ONLY used as a temporary
> solution in NXP's internal tree for Mega/Fast Mix off
> feature after suspend, upstream kernel does NOT need it,
> remove it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
