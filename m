From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 12 Nov 2015 11:09:37 +0000
Subject: [PATCH v2 1/4] drm: arm: Add DT bindings documentation for HDLCD
 driver.
In-Reply-To: <1447325545.2825.9.camel@linaro.org>
References: <1447258010-2234-1-git-send-email-Liviu.Dudau@arm.com>
 <1447258010-2234-2-git-send-email-Liviu.Dudau@arm.com>
 <20151111184849.GA9172@rob-hp-laptop>
 <20151112104210.GZ963@e106497-lin.cambridge.arm.com>
 <1447325545.2825.9.camel@linaro.org>
Message-ID: <20151112110937.GA963@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 10:52:25AM +0000, Jon Medhurst (Tixy) wrote:
> On Thu, 2015-11-12 at 10:42 +0000, Liviu Dudau wrote:
> > > This is on-chip RAM or nornal system RAM? We already have bindings
> > for 
> > > both.
> >
> > Juno has a set of TLX (ThinLinks) connectors on the board where an
> > FPGA can be attached. On r1
> > the code running on FPGA can even participate as an AXI master with
> > full coherency. The FPGA
> > has local memory that we want to share with the HDLCD to be used as a
> > framebuffer.
> 
> The HDLCD on the Juno chip or one implemented in the FPGA? I assume you
> mean the latter but just wanted to check.

You can have a GPU on the FPGA, and you want to read the framebuffer
off the FPGA's memory to render it on screen using the SoC's HDLCD. Hope
this makes sense.

Best regards,
Liviu

> 
> -- 
> Tixy
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
