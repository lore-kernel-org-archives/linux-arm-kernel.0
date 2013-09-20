From: balbi@ti.com (Felipe Balbi)
Date: Fri, 20 Sep 2013 11:24:19 -0500
Subject: [PATCH v2 3/9] ARM: OMAP2+: omap-usb-host: Get rid of
 platform_data from struct usbhs_phy_data
In-Reply-To: <20130920161822.GR9994@atomide.com>
References: <1376561909-4406-1-git-send-email-rogerq@ti.com>
 <1376561909-4406-4-git-send-email-rogerq@ti.com>
 <20130920154406.GV26101@radagast>
 <20130920161822.GR9994@atomide.com>
Message-ID: <20130920162419.GD18721@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 09:18:22AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130920 08:52]:
> > Hi,
> > 
> > On Thu, Aug 15, 2013 at 01:18:23PM +0300, Roger Quadros wrote:
> > > The platform data bits can be inferred from the other members of
> > > struct usbhs_phy_data. So get rid of the platform_data member.
> > > 
> > > Build the platform data for the PHY device in usbhs_init_phys() instead.
> > > 
> > > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > 
> > Tony, do I get your Acked-by here and all following arch/arm/mach-omap2*
> > patches in this series ?
> 
> If you can merge just this series without the .dts changes
> into an immutable topic branch against let's say v3.12-rc2
> when it comes out, then yes I can ack them:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> That way I can also pull in the topic branch as needed to
> avoid self inflicted merge conflicts ;) And Benoit can
> set up a separate .dts branch based on your branch to make
> sure the dependencies are in place before merging that one
> upstream.

Alright, i'll put this in my todo for next week.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130920/aac5c4d4/attachment.sig>
