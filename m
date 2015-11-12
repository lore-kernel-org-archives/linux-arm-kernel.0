From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 12 Nov 2015 10:52:25 +0000
Subject: [PATCH v2 1/4] drm: arm: Add DT bindings documentation for
 HDLCD driver.
In-Reply-To: <20151112104210.GZ963@e106497-lin.cambridge.arm.com>
References: <1447258010-2234-1-git-send-email-Liviu.Dudau@arm.com>
 <1447258010-2234-2-git-send-email-Liviu.Dudau@arm.com>
 <20151111184849.GA9172@rob-hp-laptop>
 <20151112104210.GZ963@e106497-lin.cambridge.arm.com>
Message-ID: <1447325545.2825.9.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-11-12 at 10:42 +0000, Liviu Dudau wrote:
> > This is on-chip RAM or nornal system RAM? We already have bindings
> for 
> > both.
>
> Juno has a set of TLX (ThinLinks) connectors on the board where an
> FPGA can be attached. On r1
> the code running on FPGA can even participate as an AXI master with
> full coherency. The FPGA
> has local memory that we want to share with the HDLCD to be used as a
> framebuffer.

The HDLCD on the Juno chip or one implemented in the FPGA? I assume you
mean the latter but just wanted to check.

-- 
Tixy
