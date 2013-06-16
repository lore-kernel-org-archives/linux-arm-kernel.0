From: mturquette@linaro.org (Mike Turquette)
Date: Sat, 15 Jun 2013 21:22:56 -0700
Subject: [PATCH 3/3] clk: tegra: T114: add DFLL DVCO reset control
In-Reply-To: <alpine.DEB.2.02.1306110944130.22645@utopia.booyaka.com>
References: <20130607121505.21868.72360.stgit@dusk.lan>
 <20130607121901.21868.65416.stgit@dusk.lan> <51B21105.1080301@wwwdotorg.org>
 <alpine.DEB.2.02.1306071703050.7753@utopia.booyaka.com>
 <51B6D239.5030905@nvidia.com>
 <alpine.DEB.2.02.1306110944130.22645@utopia.booyaka.com>
Message-ID: <20130616042256.7541.7096@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Paul Walmsley (2013-06-11 02:47:13)
> On Tue, 11 Jun 2013, Prashant Gaikwad wrote:
> 
> > Why not implement these APIs in DFLL clock driver itself and pass RST address
> > register to driver?
> 
> The DFLL DVCO reset registers are CAR registers, not DFLL registers.  
> Functions that operate on registers in one IP block shouldn't be located 
> in another IP block's driver.

Paul & Co.,

These patches appear fine to me but I did not see any Acks, nor could I
tell if a v2 was necessary based on the comments. Will there be another
version? If not an Acked-by or Reviewed-by would be cool.

Regards,
Mike

> 
> 
> - Paul
