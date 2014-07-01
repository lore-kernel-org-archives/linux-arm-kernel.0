From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 1 Jul 2014 17:21:11 +0800
Subject: [PATCH] ARM: mx6: Only check for 1.2GHz for mx6quad
In-Reply-To: <1404184372-5321-1-git-send-email-festevam@gmail.com>
References: <1404184372-5321-1-git-send-email-festevam@gmail.com>
Message-ID: <20140701092109.GL14471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 12:12:52AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> It is only the mx6quad variant that can run up to 1.2GHz, so add the check 
> accordingly.
> 
> This avoids getting the following warning on a mx6solo:
> 
> failed to disable 1.2 GHz OPP
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
