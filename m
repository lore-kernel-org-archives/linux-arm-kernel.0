From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 12 Jul 2018 10:52:04 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sll: add gpio clocks
In-Reply-To: <1529649154-5724-2-git-send-email-Anson.Huang@nxp.com>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
 <1529649154-5724-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180712025203.GQ6959@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 02:32:34PM +0800, Anson Huang wrote:
> i.MX6SLL has GPIO clock gates in CCM CCGR, add
> clock property for GPIO driver to make sure all
> GPIO banks work as expected.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

I tried to create a topic branch for this patch with dependent clk
branch merged in.  But it turns out to be difficult and not worth the
effort, because too many imx6sll patches need to be moved out from
imx/dt branch, and some imx6sll changes are mixed with other SoCs.
Let's apply this in next cycle.  Ping me when 4.19-rc1 is available.

Shawn
