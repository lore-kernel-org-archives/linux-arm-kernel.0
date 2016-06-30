From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 30 Jun 2016 21:52:15 +0100
Subject: [PATCH 6/6] spi: st-ssc4: Remove 'no clocking' hack
In-Reply-To: <20160607151712.GA7510@sirena.org.uk>
References: <20160607111930.10375-1-lee.jones@linaro.org>
 <20160607111930.10375-7-lee.jones@linaro.org>
 <20160607151712.GA7510@sirena.org.uk>
Message-ID: <20160630205215.GF1707@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 07 Jun 2016, Mark Brown wrote:
> On Tue, Jun 07, 2016 at 12:19:30PM +0100, Lee Jones wrote:
> > Due to the newly upstreamed 'critical clocks' API we can now
> > safely handle clocking in the SPI and I2C drivers without fear
> > of catastrophically crippling the running platform.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

We really need to guarantee that this goes in *after* the other
patches have landed, and it looks like they're heading in via their
own respective trees.  Any chance you can hold this back and submit it
via your v4.8-fixes submission?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
