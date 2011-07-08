From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 8 Jul 2011 09:45:13 +0800
Subject: [PATCH 1/2] dt: add helper function to read u32 arrays
In-Reply-To: <20110706205933.GA5371@ponder.secretlab.ca>
References: <1309984979-8847-1-git-send-email-robherring2@gmail.com>
	<20110706205933.GA5371@ponder.secretlab.ca>
Message-ID: <20110708014512.GD12722@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 02:59:33PM -0600, Grant Likely wrote:
> On Wed, Jul 06, 2011 at 03:42:58PM -0500, Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > Rework of_property_read_u32 to read an array of values. Then
> > of_property_read_u32 becomes an inline with array size of 1.
> > 
> > Also make struct device_node ptr const.
> > 
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > Cc: Thomas Abraham <thomas.abraham@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > 
> > Grant, 
> > 
> > Perhaps you want to roll this into the original patch?
> 
> Applied, thanks.  The original is already in devicetree/next, so I've
> just applied this on top as a separate commit.
> 
> > 
> > It would also be nice if there were empty versions of the helpers
> > as well.
> 
> Go ahead and submit a patch to add them if you need it.
> 
I'm adding one into my spi-dt series, as I need it there.

-- 
Regards,
Shawn
