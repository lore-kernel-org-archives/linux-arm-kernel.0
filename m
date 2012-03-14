From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 14 Mar 2012 03:30:26 +0000
Subject: Want to Get Suggestion for MX28 USB Submisson
In-Reply-To: <CAOMZO5C3Y3kP5k_CKkCVMVdDem2T82g6F3uL=8GCVfNKHpdymA@mail.gmail.com>
References: <35AB98346D25394A9354ED89C4D76587225CFF@039-SN1MPN1-002.039d.mgd.msft.net>
 <201202041117.48190.marek.vasut@gmail.com>
 <F281D0F91ED19E4D8E63A7504E8A6498033336@039-SN2MPN1-021.039d.mgd.msft.net>
 <201202100447.14248.marek.vasut@gmail.com>
 <CAOMZO5C3Y3kP5k_CKkCVMVdDem2T82g6F3uL=8GCVfNKHpdymA@mail.gmail.com>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A6498093839@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> Hi Peter,
> 
> On Fri, Feb 10, 2012 at 1:47 AM, Marek Vasut <marek.vasut@gmail.com>
> wrote:
> 
> > Oh, so you're still working on it. All right then, I'll now dive into
> the IIO
> > LRADC driver and let you handle this.
> 
> Do you plan to re-submit the mxs usb driver?
> 
According to sascha's suggestion, it is better to re-submit after we have
a generic USB PHY Layer in mainline.

Currently, Heikki's split PHY from OTG structure patches have mainlined, 
next step is to submit a generic USB PHY driver.

> Regards,
> 
> Fabio Estevam
