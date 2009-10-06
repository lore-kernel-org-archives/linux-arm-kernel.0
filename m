From: rene.wolf@mbda-systems.de (Wolf, Rene, HRO-GP)
Date: Tue, 6 Oct 2009 09:22:23 +0200
Subject: imx SDMA
In-Reply-To: <200910060857.52469.null@rez.ru>
References: <200910060857.52469.null@rez.ru>
Message-ID: <87077C4F48609F4392621D9F99DDE20901202E0D@tesla.star.galaxy.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexei.

If you're intereseted in drivers using the SDMA there are two, for
the i.MX platform. Both use some dma api, one of em the SDMA api, afaik.
/u/s/l/drivers/mmc/host/mxc_mmc.c 
/u/s/l/drivers/mmc/host/imxmmc.c
The point is, those two differ in the recent kernel versions. The one
I refer to is the 2.6.22 from the LTIB (http://ltib.org/) for i.MX31.

What would that torrent contain?


Thanks and
Cheers
Rene


Rene Wolf
LFK-Lenkflugk?rpersysteme GmbH
Human Resources Operations & Policy, HRO
Landshuter Stra?e 26, 85716 Unterschlei?heim, GERMANY
Phone: +49 89 3179 8337
Fax: +49 8252 99 8964
E-Mail: rene.wolf at mbda-systems.de

http://www.mbda.net

Chairman of the Supervisory Board: Antoine Bouvier
Managing Director: Werner Kaltenegger
Registered Office: Schrobenhausen
Commercial Register: Amtsgericht Ingolstadt, HRB 4365
