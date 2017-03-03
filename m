From: briannorris@chromium.org (Brian Norris)
Date: Fri, 3 Mar 2017 12:41:49 -0800
Subject: [PATCH] dt-bindings: display: rk3288-mipi-dsi: add reset property
In-Reply-To: <20170303113945.3bd2cbd9.john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
 <20170224125506.21533-24-john@metanate.com>
 <20170302215643.GA49163@google.com>
 <20170303113945.3bd2cbd9.john@metanate.com>
Message-ID: <20170303204148.GA78598@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 11:39:45AM +0000, John Keeping wrote:
> This reset is required in order to fully reset the internal state of the
> MIPI controller.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> On Thu, 2 Mar 2017 13:56:46 -0800, Brian Norris wrote:
> > On Fri, Feb 24, 2017 at 12:55:06PM +0000, John Keeping wrote:
> > > +	/*
> > > +	 * Note that the reset was not defined in the initial device tree, so
> > > +	 * we have to be prepared for it not being found.
> > > +	 */
> > > +	apb_rst = devm_reset_control_get(dev, "apb");  
> > 
> > Did this reset ever get documented in the device tree bindings? I
> > couldn't find it. Perhaps a follow-up patch is in order?
> 
> Here's a patch to do that.

FWIW:

Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks.
