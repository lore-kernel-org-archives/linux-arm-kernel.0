From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 11 May 2016 21:50:14 +0200
Subject: [PATCH] ARM: imx6ul: Fix Micrel PHY mask
In-Reply-To: <1462995570-31055-1-git-send-email-festevam@gmail.com>
References: <1462995570-31055-1-git-send-email-festevam@gmail.com>
Message-ID: <20160511195014.GA17613@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 04:39:30PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The value used for Micrel PHY mask is not correct. Use the 
> MICREL_PHY_ID_MASK definition instead.
> 
> Thanks to Jiri Luznicky for proposing the fix at
> https://community.freescale.com/thread/387739
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 709bc0657fe6f9f55 ("ARM: imx6ul: add fec MAC refrence clock and phy fixup init")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

It would be nice if drivers/net/phy/micrel.c was to use
MICREL_PHY_ID_MASK. But that is a different patch.

Thanks
	Andrew		    
