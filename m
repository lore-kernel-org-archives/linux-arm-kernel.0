From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 26 Oct 2010 16:47:04 +0200
Subject: PXA270 Random Hangs at Low Core Freq
In-Reply-To: <D31D5F61-63E8-4C37-A880-7840336935F8@prograde.net>
References: <471CD45F-4531-4C87-B292-411CE519D0A5@prograde.net>
	<201010252146.05874.marek.vasut@gmail.com>
	<D31D5F61-63E8-4C37-A880-7840336935F8@prograde.net>
Message-ID: <201010261647.04676.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 October 2010 22:53:32 Michael Cashwell wrote:
> On Oct 25, 2010, at 3:46 PM, Marek Vasut wrote:
> > I think I noticed something similar running ZipitZ2 on 312MHz ... yet I
> > was unable to figure out the problem as well ...
> 
> Out of curiosity, what was your trigger event? MMC activity or something
> else?

I believe it might have been MMC activity, as in initramfs it wasn't triggered
> 
> -Mike
