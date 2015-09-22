From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Sep 2015 14:03:14 +0800
Subject: [PATCH v2 00/10] USB: chipidea misc patches
In-Reply-To: <20150805140813.GO12927@tiger>
References: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
 <20150805140813.GO12927@tiger>
Message-ID: <20150922060313.GC20558@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 10:08:14PM +0800, Shawn Guo wrote:
> On Mon, Aug 03, 2015 at 12:47:08PM +0800, Peter Chen wrote:
> > Hi all,
> > 
> > In this series, I add several new interfaces for chipidea driver,
> > they are mainly for system configuration adjustment. The USB
> > performance may be improved with these configuration changing,
> > but each vendor driver owner needs to consult with your IC
> > owner which configuration parameters are suitable for your system
> > before changing it, and only change it if necessary.
> > 
> > The other changes are for imx, it shows how imx uses these interfaces.
> > Shawn, the patch [5/10] and [9/10] are dts changes, help to review it
> > please.
> 
> Ping me, after driver and bindings are accepted.  Then I will pick up
> the dts changes.
> 

Shawn, The driver and bingings have been accepted.
And I send v2 changes for you, which apply changes for imx6ul.

-- 

Best Regards,
Peter Chen
