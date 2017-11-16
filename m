From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Nov 2017 19:53:37 +0800
Subject: [PATCH] Revert "ARM: dts: imx53: add srtc node"
In-Reply-To: <1510747433-23503-1-git-send-email-festevam@gmail.com>
References: <1510747433-23503-1-git-send-email-festevam@gmail.com>
Message-ID: <20171116115336.GT25384@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 10:03:53AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> This reverts commit 5b725054147deaf966b3919e10a86c6bfe946a18.
> 
> The rtc block on i.MX53 is a completely different hardware than the
> one found on i.MX25.
> 
> Cc: <stable@vger.kernel.org> #4.14
> Reported-by: Noel Vellemans <Noel.Vellemans@visionbms.com>
> Suggested-by: Juergen Borleis <jbe@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
