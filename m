From: mchehab@kernel.org (Mauro Carvalho Chehab)
Date: Thu, 14 Dec 2017 15:35:43 -0200
Subject: [PATCH] media: v4l: xilinx: Use SPDX-License-Identifier
In-Reply-To: <1513272387.27409.69.camel@perches.com>
References: <20171208123537.18718-1-dhaval23031987@gmail.com>
 <20171214150527.00dca6cc@vento.lan>
 <1513272387.27409.69.camel@perches.com>
Message-ID: <20171214153543.598ca985@vento.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Thu, 14 Dec 2017 09:26:27 -0800
Joe Perches <joe@perches.com> escreveu:

> On Thu, 2017-12-14 at 15:05 -0200, Mauro Carvalho Chehab wrote:
> > Em Fri,  8 Dec 2017 18:05:37 +0530
> > Dhaval Shah <dhaval23031987@gmail.com> escreveu:
> >   
> > > SPDX-License-Identifier is used for the Xilinx Video IP and
> > > related drivers.
> > > 
> > > Signed-off-by: Dhaval Shah <dhaval23031987@gmail.com>  
> > 
> > Hi Dhaval,
> > 
> > You're not listed as one of the Xilinx driver maintainers. I'm afraid that,
> > without their explicit acks, sent to the ML, I can't accept a patch
> > touching at the driver's license tags.  
> 
> And even a maintainer may not have the sole right
> to modify a license.

Very true. I was actually expecting a patch like that either authored
or explicitly sanctioned by either one of those developers:

Hyun Kwon <hyun.kwon@xilinx.com> (supporter:XILINX VIDEO IP CORES)
Michal Simek <michal.simek@xilinx.com> (supporter:ARM/ZYNQ ARCHITECTURE)

As they own an @xilinx.com, we could assume that an email from
their corporate accounts to be official.

Thanks,
Mauro
