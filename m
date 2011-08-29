From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 29 Aug 2011 22:54:04 +0100
Subject: How to handle named resources with DT?
In-Reply-To: <alpine.DEB.2.00.1108271444240.23968@utopia.booyaka.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<877h6173wm.fsf@ti.com> <20110826041200.GD2308@yookeroo.fritz.box>
	<201108261258.32880.arnd@arndb.de>
	<20110826130644.GN2308@yookeroo.fritz.box>
	<alpine.DEB.2.00.1108271444240.23968@utopia.booyaka.com>
Message-ID: <20110829215404.GA26846@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 27, 2011 at 03:47:55PM -0600, Paul Walmsley wrote:

> Certainly, from a kernel development perspective, one can decide to just 
> dump this kind of DT generation problem back on the hardware vendors.  
> But it seems more efficient and less error-prone to simply remove both 
> mapping tables, and to export names directly from the IP block data into 
> the device data format.

That seems sensible, though we'd probably want to keep the option to
remap in there at least on the generation side in case some integrators
end up renaming the ports on the IP block for some reason.
