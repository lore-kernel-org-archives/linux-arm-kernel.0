From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 2 Nov 2016 08:01:39 +0000
Subject: [PATCHv2 3/4] mfd: altr-a10sr: Add Arria10 SR Monitor
In-Reply-To: <39faa26d-ca05-d68d-a50a-03d09d445b77@opensource.altera.com>
References: <1477598426-28125-1-git-send-email-tthayer@opensource.altera.com>
 <1477598426-28125-4-git-send-email-tthayer@opensource.altera.com>
 <20161031080222.GM13127@dell>
 <39faa26d-ca05-d68d-a50a-03d09d445b77@opensource.altera.com>
Message-ID: <20161102080138.GQ13127@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 Oct 2016, Thor Thayer wrote:
> On 10/31/2016 03:02 AM, Lee Jones wrote:
> > On Thu, 27 Oct 2016, tthayer at opensource.altera.com wrote:
> > 
> > > From: Thor Thayer <tthayer@opensource.altera.com>
> > > 
> > > Add the Altera Arria10 DevKit System Resource Monitor functionality
> > > to the MFD device.
> > > 
> > > Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> > > ---
> > > v2  Change from -mon to -monitor for clarity
> > > ---
> > >  drivers/mfd/altera-a10sr.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/mfd/altera-a10sr.c b/drivers/mfd/altera-a10sr.c
> > > index 06e1f7f..30de652 100644
> > > --- a/drivers/mfd/altera-a10sr.c
> > > +++ b/drivers/mfd/altera-a10sr.c
> > > @@ -33,6 +33,10 @@
> > >  		.name = "altr_a10sr_gpio",
> > >  		.of_compatible = "altr,a10sr-gpio",
> > >  	},
> > > +	{
> > > +		.name = "altr_a10sr_monitor",
> > > +		.of_compatible = "altr,a10sr-monitor",
> > 
> > So long as you use whichever compatible you agree on with Rob:
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> I'm getting a "Non-standard signature" warning for this (even if I make
> everything lower-case).
> 
> Would you prefer I submit it with the warning or should I change it to
> "Acked-by"?

Please submit it as you see it.  I will amend when applying.

> Thanks for reviewing!
> 
> Thor
> 
> > > +	},
> > >  };
> > > 
> > >  static bool altr_a10sr_reg_readable(struct device *dev, unsigned int reg)
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
