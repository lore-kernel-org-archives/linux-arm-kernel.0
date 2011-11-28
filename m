From: gregkh@suse.de (Greg KH)
Date: Mon, 28 Nov 2011 14:32:25 +0900
Subject: Want to Get Suggestion for MX28 USB Submisson
In-Reply-To: <35AB98346D25394A9354ED89C4D76587225D7E@039-SN1MPN1-002.039d.mgd.msft.net>
References: <35AB98346D25394A9354ED89C4D76587225CFF@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111128045733.GA9194@suse.de>
 <35AB98346D25394A9354ED89C4D76587225D7E@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20111128053225.GA12779@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 05:24:00AM +0000, Chen Peter-B29397 wrote:
>  
> > >
> > > Tony Lin has submitted Freescale mx28 USB Patch at August
> > > (See: http://www.spinics.net/lists/linux-usb/msg50201.html), but it
> > hasn't been accepted.
> > 
> > Why wasn't it accepted?  Have the issues raised from that last posting
> > of the driver now been addressed?  If not, why not?  If so, great.
> > 
> Sascha suggested that use another platform device driver for transceiver,
> and follow heikki's suggested otg structure. Since heikki's otg structure is
> still not accepted, I will write a device driver for this freescale 
> transceiver at coming submission. 

Why not work to get the OTG stuff accepted, that should make your life
easier, right?

thanks,

greg k-h
