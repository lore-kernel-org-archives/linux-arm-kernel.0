From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 15 May 2011 21:26:22 +0200
Subject: I80 interface on S3C and manual command mode
Message-ID: <201105152126.22338.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm working on porting a kernel to a device which has an epaper-controller 
connected to the I80 interface of an S3C2416 and uses its "manual command 
mode", via SIFCCON[0,1,2], as the datasheet calls it.

While digging around the mailinglists I found patches by Inki Dae that 
implement the I80 basics. (cpu_mode struct and probe_win).

As there are multiple versions available in the fbdev patchwork and the i80 
interface seems to have been dropped in the latest version from 2011-04 I'd 
like ask if there are "final" versions laying around somewhere.

Also, to not reinvent the wheel, does an implementation of the i80 interface 
[via SIFCCONx] for s3c-fb exist somewhere per chance?

Thanks
Heiko
