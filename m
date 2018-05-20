From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 20:43:00 +0800
Subject: [PATCH] ARM: dts: imx7s-warp: remove unnecessary cpu regulator
 supply
In-Reply-To: <1526375895-23633-1-git-send-email-Anson.Huang@nxp.com>
References: <1526375895-23633-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180520124259.GW26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 05:18:15PM +0800, Anson Huang wrote:
> i.MX7S does NOT support CPU frequency scaling, so no
> need to specify the CPU regulator supply.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
