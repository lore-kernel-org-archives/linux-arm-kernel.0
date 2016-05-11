From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 May 2016 16:53:50 -0300
Subject: [PATCH] ARM: imx6ul: Fix Micrel PHY mask
In-Reply-To: <20160511195014.GA17613@lunn.ch>
References: <1462995570-31055-1-git-send-email-festevam@gmail.com>
 <20160511195014.GA17613@lunn.ch>
Message-ID: <CAOMZO5AaspTp+K6+N=fHvYDSEuUE9Ab4TQFeNtRmDtcn78sW+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 4:50 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
> It would be nice if drivers/net/phy/micrel.c was to use
> MICREL_PHY_ID_MASK. But that is a different patch.

Good suggestion. I will submit a patch doing this. Thanks
