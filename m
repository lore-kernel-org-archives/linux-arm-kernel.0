From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 8 Oct 2018 15:21:48 +0200
Subject: [PATCH 01/14] phy: phy-pxa-usb: add a new driver
In-Reply-To: <1981ce54ce960d21976ce71b08a8779bfeb13be4.camel@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
 <20180822204307.13251-2-lkundrak@v3.sk>
 <f36abb62-e8a4-e69f-4732-95a0db466034@ti.com>
 <1981ce54ce960d21976ce71b08a8779bfeb13be4.camel@v3.sk>
Message-ID: <20181008132148.GC20703@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 07, 2018 at 08:47:28PM +0200, Lubomir Rintel wrote:
> On Tue, 2018-09-25 at 10:53 +0530, Kishon Vijay Abraham I wrote:
> > 
> > On Thursday 23 August 2018 02:12 AM, Lubomir Rintel wrote:
> > > Turned from arch/arm/mach-mmp/devices.c into a proper PHY driver,
> > > so
> > > that in can be instantiated from a DT.
> > > 
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > 
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > 
> > If this has to be merged via linux-phy tree, please let me know.
> 
> Yes, either linux-phy or the usb tree.
> 
> The EHCI patches have already been pulled into the usb tree, presumably
> because they got an Ack from Alan Stern. That includes "USB: EHCI:
> ehci-mv: use phy-pxa-usb" that depends on this. Perhaps the  rest of
> the patches can go via the same tree?
> 
> I haven't submitted a patchset that would have dependencies spanning
> across different subsystems before. I don't know what's usually done in
> such cases. Advice welcome.
> 
> Greg?

You can either send them through the same tree, or wait a release cycle
and get the rest in through a different one.  As I usually take the phy
tree into the USB tree for issues like this, I can take them all if you
get the phy maintainer to ack them.

thanks,

greg k-h
