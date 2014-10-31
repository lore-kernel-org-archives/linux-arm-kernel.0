From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Fri, 31 Oct 2014 17:17:24 +0100
Subject: [PATCH] VNIC: Adding support for Cavium ThunderX network
 controller
In-Reply-To: <20141030194513.089d27ec@urahara>
References: <20141030165434.GW20170@rric.localhost>
 <20141030194513.089d27ec@urahara>
Message-ID: <20141031161724.GC31556@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.10.14 19:45:13, Stephen Hemminger wrote:
> On Thu, 30 Oct 2014 17:54:34 +0100
> Robert Richter <rric@kernel.org> wrote:
> 
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 1fa99a301817..80bd3336691e 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2324,6 +2324,8 @@
> >  #define PCI_DEVICE_ID_ALTIMA_AC9100	0x03ea
> >  #define PCI_DEVICE_ID_ALTIMA_AC1003	0x03eb
> >  
> > +#define PCI_VENDOR_ID_CAVIUM		0x177d
> 
> I don't think PCI folks want this updated with every id anymore.

This is just the vendor id, the device id is part of the driver.

Since there will be multiple drivers I put the vendor id here.

-Robert
