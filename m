From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 25 Sep 2014 15:54:34 +0800
Subject: [PATCH 1/2] ARM: dts: imx53: Improve SSI clocks description
In-Reply-To: <1411082629-25860-1-git-send-email-festevam@gmail.com>
References: <1411082629-25860-1-git-send-email-festevam@gmail.com>
Message-ID: <20140925075433.GE6405@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 08:23:48PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> SSI block has 'ipg' clock for internal peripheral access and also 'baud' clock
> for generating bit clock when SSI operates in master mode.
> 
> Add the extra 'baud' clock so that we can have SSI functional in master mode. 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied both, thanks.
