From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Wed, 04 Jun 2014 03:00:37 +0200
Subject: Tegra 2 T20 NAND Flash Support
Message-ID: <538E6FB5.5020806@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for referring to an old post of yours:

 > From: Thierry Reding <thierry.reding@...>
 > Subject: Re: [PATCH V5 7/9] ARM: dts: tegra: add non-removable and 
keep-power-in-suspend property for MMC
 > Date: 2013-04-03 05:45:49 GMT (1 year, 8 weeks, 5 days, 12 hours and 
59 minutes ago)
 > ...
 > For Tegra20 Tamonten we don't use eMMC. Ideally we'd be using NAND to
 > boot from but that doesn't have mainline support. I have a semi-working
 > patch and will probably spend some more time getting it ready. The MMC
 > cards are all removable, though I guess since they are the boot device
 > they still should remain powered in suspend?

You might have noticed our current effort in further mainlining 
Apalis/Colibri T30 module support. In the same respect we are looking at 
further improving Colibri T20 support. One of the major missing pieces 
is of course the NAND support you were mentioning in that 14 months old 
post. Have you by any chance made any progress on this? As me (on PXA) 
and Stefan (on Vybrid) do have quite some experience in the MTD NAND 
infrastructure there might be a chance for some joint effort in that 
respect. What do you think? Of course any other contribution/feedback is 
also most welcome.
