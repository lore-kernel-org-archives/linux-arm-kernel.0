From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 6 Jul 2011 19:59:46 +0800
Subject: [PATCH v2 0/3] Add device tree probe support for imx fec driver
In-Reply-To: <20110706062901.GJ9978@ponder.secretlab.ca>
References: <20110705.194854.1875695946300840388.davem@davemloft.net>
	<20110705.223045.738515407552627580.davem@davemloft.net>
	<20110706061901.GH9978@ponder.secretlab.ca>
	<20110705.232252.897826991160254269.davem@davemloft.net>
	<20110706062901.GJ9978@ponder.secretlab.ca>
Message-ID: <20110706115944.GA4034@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 12:29:01AM -0600, Grant Likely wrote:
> On Tue, Jul 05, 2011 at 11:22:52PM -0700, David Miller wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> > Date: Wed, 6 Jul 2011 00:19:01 -0600
> > 
> > > Sorry about that, I missed the reference to that function which is
> > > currently in my devicetree/next branch.  I can either take the series
> > > via devicetree/next, or I can provide you with a topic branch
> > > containing the needed commit that you can merge.  Whichever you prefer.
> > 
> > Please just take the series, thanks.
> 
> Will do.
> 
Grant, please hold for a while.  I will send an update to use
of_get_named_gpio for phy-reset-gpios.

-- 
Regards,
Shawn
