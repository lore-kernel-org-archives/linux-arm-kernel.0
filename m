From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Feb 2018 11:04:38 +0800
Subject: [PATCH] ARM: imx: pm-imx6: Return the error directly
In-Reply-To: <1519436524-24583-1-git-send-email-festevam@gmail.com>
References: <1519436524-24583-1-git-send-email-festevam@gmail.com>
Message-ID: <20180228030437.GD3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 10:42:04PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Simplify the error path by returning the error code directly rather
> than jumping to a label.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
