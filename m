From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Mar 2016 11:10:09 +0100
Subject: [PATCH 2/4] mfd: axp20x: Add AXP209 GPIO driver to the mfd
In-Reply-To: <20160329095838.GJ30977@lukather>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
 <1457520614-32239-3-git-send-email-maxime.ripard@free-electrons.com>
 <20160321115410.GC4140@x1> <20160329095838.GJ30977@lukather>
Message-ID: <20160329101009.GE8659@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Mar 2016, Maxime Ripard wrote:

> Hi Lee,
> 
> On Mon, Mar 21, 2016 at 11:54:10AM +0000, Lee Jones wrote:
> > On Wed, 09 Mar 2016, Maxime Ripard wrote:
> > 
> > > Now that we have a GPIO driver for the AXP209, we can add it to our MFD.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > ---
> > >  drivers/mfd/axp20x.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > 
> > Applied, thanks.
> 
> There's still some discussions about the whole design of the driver,
> can you drop that patch for now?

Sure.  Done.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
