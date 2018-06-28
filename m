From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jun 2018 11:25:11 +0800
Subject: [PATCH] ARM: dts: imx6sll: declare src module to be compatible
 to imx51's src
In-Reply-To: <1529483917-18057-1-git-send-email-Anson.Huang@nxp.com>
References: <1529483917-18057-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180628032510.GH22683@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 04:38:37PM +0800, Anson Huang wrote:
> i.MX6SLL uses same SRC module as i.MX51, add "fsl,imx51-src"
> compatible string to enable SRC driver to support setting
> CPU resume address for cpu-idle and suspend/resume.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
