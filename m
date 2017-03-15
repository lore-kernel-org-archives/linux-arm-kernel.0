From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 15 Mar 2017 14:28:21 +0800
Subject: [PATCH v3] clk: imx: clk-imx6ul: The i.mx6ul has no aips_tz3 clock
In-Reply-To: <20170314115514.7ea25d1c@erd979>
References: <20170303141405.17581-1-robin@protonic.nl>
 <20170314115514.7ea25d1c@erd979>
Message-ID: <20170315062819.GQ3618@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 11:55:14AM +0100, Robin van der Gracht wrote:
> On Fri,  3 Mar 2017 15:14:05 +0100
> Robin van der Gracht <robin@protonic.nl> wrote:
> 
> > The clock was mapped on CG15 (gpio2_clocks) in the CCRG0 register.
> > 
> > Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> > Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> 
> Sasha or Shawn would you mind pushing this patch upstream?
> I don't have a path.

I think Stephen will take care of it.

Shawn
