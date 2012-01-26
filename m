From: dhlii@dlasys.net (David Lynch Jr.)
Date: Thu, 26 Jan 2012 09:04:05 -0500
Subject: [Fwd: Re: imx53]
In-Reply-To: <4F20FC29.2060500@de.bosch.com>
References: <1327517782.21058.49.camel@hp-dhlii>
 <4F20FC29.2060500@de.bosch.com>
Message-ID: <1327586645.8900.19.camel@hp-dhlii>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thu, 2012-01-26 at 08:09 +0100, Dirk Behme wrote:
> On 25.01.2012 19:56, David Lynch Jr. wrote:
> > I just pulled the most recent copy of linus's tree 3.3 something. 
> > It appears that significantly more i.mx53 drivers are getting into that
> > source than last time I looked. 
> > 
> > Now I am trying to build it for the i.MX53 QSB - the development
> > platform I am using. 
> > 
> > Myriads of config options have changed since the 2.6.38.3 that I have
> > somewhat working. Just borrowing the .config appears to be
> > insufficient. 
> > 
> > After some mucking arround that included Kconfig changes I was able to
> > get CONFIG_FB_IMX set and build a kernel with it, but it does not appear
> > to be getting initialized. 
> > 
> > What do I need to do to get Linux to use this driver ?
> > Has ARM 3.3 moved to device trees ?
> 
> Yes, I think so.
> 
> If you are new to this, one option would be to start with a recent 
> Linaro i.MX53 Loco build (binary distribution). This could be a good 
> option to get an idea how U-Boot, device tree and the kernel work 
> together. In the next step you could replace the parts you are 
> interested in by your own versions, then. E.g. the kernel.

I am new to dealing with the i.MX53.
I have done alot of work with various PowerPC's, as well as OMAP ARM's.
I contributed to getting Xilinx support into the kernel.org source.
I have been playing around with a variety of vendor and consultant trees
including the Linaro  ones. 

I am familiar with u-boot, device tree. I was not familiar with the
state of device trees and ARM in current kernels. 

Once I know what I am starting from I can deal with whatever state the
current kernel is in. I would prefer to work there, I would hope that in
six months or so this should be sorted out. Maybe I can help.  

thank You
 
