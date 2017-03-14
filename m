From: robin@protonic.nl (Robin van der Gracht)
Date: Tue, 14 Mar 2017 11:55:14 +0100
Subject: [PATCH v3] clk: imx: clk-imx6ul: The i.mx6ul has no aips_tz3 clock
In-Reply-To: <20170303141405.17581-1-robin@protonic.nl>
References: <20170303141405.17581-1-robin@protonic.nl>
Message-ID: <20170314115514.7ea25d1c@erd979>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  3 Mar 2017 15:14:05 +0100
Robin van der Gracht <robin@protonic.nl> wrote:

> The clock was mapped on CG15 (gpio2_clocks) in the CCRG0 register.
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>

Sasha or Shawn would you mind pushing this patch upstream?
I don't have a path.

Best regards,
Robin
