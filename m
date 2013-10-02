From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 02 Oct 2013 06:54:34 -0700
Subject: [PATCH] clk: wm831x: get rid of the implementation of remove
 function
In-Reply-To: <20130926144743.GQ19304@sirena.org.uk>
References: <1380203295-11030-1-git-send-email-ldewangan@nvidia.com>
 <20130926144743.GQ19304@sirena.org.uk>
Message-ID: <20131002135434.9338.99565@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mark Brown (2013-09-26 07:47:43)
> On Thu, Sep 26, 2013 at 07:18:15PM +0530, Laxman Dewangan wrote:
> > The remove function implemented for platform driver's remove callback
> > just return 0 as part of its implementation.
> > 
> > Remove this APIs and do not pass the valid .remove for platform driver.
> 
> Yes, this should have been done when the driver was coverted to
> devm_clk_register()
> 
> Acked-by: Mark Brown <broonie@linaro.org>

Taken into clk-next.

Thanks,
Mike
