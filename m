From: csamsel@gmxpro.de (Christian Samsel)
Date: Fri, 26 Mar 2010 13:53:47 +0100
Subject: Problems with DNS-323 revision A1 power LED patch
In-Reply-To: <87bpebl3q7.fsf@lechat.rtp-net.org>
References: <20100326104300.GA28935@jirafa.cyrius.com>
	<87bpebl3q7.fsf@lechat.rtp-net.org>
Message-ID: <201003261353.48338.csamsel@gmxpro.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 26. M?rz 2010 12:30:40 schrieb Arnaud Patard:

> This warning is there to tell people that a gpio direction was set but
> the gpio has not been requested. I believe the following patch would fix
> it (warning I've not build-tested it). If it's working, I'll send it
> again with proper s-o-b.
> 
> Arnaud

Martin prepared me a patched kernel which i just tested. the traceback is 
gone. although i wasnt able to check if the led is still functional, cause i'm 
not at home. i'll report back later the day, if not.

Christian
