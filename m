From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 04 Aug 2011 10:58:47 +0530
Subject: [PATCH v2 0/3] Add device tree probe for imx-sdma driver
In-Reply-To: <20110804053504.GA3311@freescale.com>
References: <1310723066-567-1-git-send-email-shawn.guo@linaro.org>
	<1312430372.1536.554.camel@vkoul-udesk3>
	<20110804053504.GA3311@freescale.com>
Message-ID: <1312435727.1536.562.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-04 at 13:35 +0800, Shawn Guo wrote:
> On Thu, Aug 04, 2011 at 09:29:32AM +0530, Koul, Vinod wrote:
> > On Fri, 2011-07-15 at 17:44 +0800, Shawn Guo wrote:
> > > The first patch remove the use of software defined sdma version, and
> > > instead uses platform_device_id to handle the sdma differences from
> > > one soc to another.  The second one makes a small cleanup on function
> > > sdma_get_firmware(), and the third patch adds the actual device tree
> > > probe support.
> > > 
> > > Changes since v1:
> > >  * Do not encode ROM script address in device tree
> > >  * Add one more small cleanup on function sdma_get_firmware()
> > > 
> > > ShawnsGuo (3):
> > >       dmaengine: imx-sdma: use platform_device_id to identify sdma version
> > >       dmaengine: imx-sdma: sdma_get_firmware does not need to copy fw_name
> > >       dmaengine: imx-sdma: add device tree probe support
> > > 
> > Sacha are you okay if this go via my tree, would need your ack before I
> > take this one
> > 
> Hi Vinod,
> 
> Sorry if I have misunderstood your reply below, but the series has
> gone into mainline through arm tree.
> 
Okay i thought this was still pending from me.

> Regards,
> Shawn
> 
> ---- Quote ---
> On Mon, Jul 25, 2011 at 05:11:55PM +0530, Vinod Koul wrote:
> > On Fri, 2011-07-22 at 11:54 +0800, Shawn Guo wrote:
> > > Hi Vinod,
> > >
> > > Can I have your ack on this series, please?  I attempt to get it
> > > merged through Sascha's tree after his tree and devicetree/next get
> > > merged in the coming window.
> > >
> > > Regards,
> > > Shawn
> > >
> > > On Fri, Jul 15, 2011 at 05:44:23PM +0800, Shawn Guo wrote:
> > > >
> > > > ShawnsGuo (3):
> > > >       dmaengine: imx-sdma: use platform_device_id to identify sdma version
> > > >       dmaengine: imx-sdma: sdma_get_firmware does not need to copy fw_name
> > > >       dmaengine: imx-sdma: add device tree probe support
> > > >
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> >
> > I had queued this up for my tree, i am okay if it gets merged thru
> > Sascha
> >
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
~Vinod
