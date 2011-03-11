From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 11 Mar 2011 23:13:51 +0100
Subject: [PATCH v2 2/8] ARM: PXA: Z2: Enable OHCI on Zipit Z2
In-Reply-To: <201103112355.29081.anarsoul@gmail.com>
References: <1299839023-16601-2-git-send-email-anarsoul@gmail.com>
	<201103112250.56967.marek.vasut@gmail.com>
	<201103112355.29081.anarsoul@gmail.com>
Message-ID: <201103112313.51491.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 22:55:28 Vasily Khoruzhick wrote:
> On Friday 11 March 2011 23:50:56 Marek Vasut wrote:
> > On Friday 11 March 2011 22:49:13 Vasily Khoruzhick wrote:
> > > On Friday 11 March 2011 23:42:30 Marek Vasut wrote:
> > > > On Friday 11 March 2011 15:56:46 Vasily Khoruzhick wrote:
> > > > > This patch is a part of similar mozzwald's patch which was
> > > > > based on GPSFan and rkdavis work.
> > > > 
> > > > Noone knows what/who is "mozzwald" or "rkdavis" or "GPSFan", the
> > > > comment for this patch is irelevant and has zero information value.
> > > 
> > > Heh, I can add 'from Zipit Z2 community', I don't know their actual
> > > names nor mail addresses.
> > 
> > That's not the point. The point is the comment has zero value, it doesn't
> > describe the change.
> > 
> > > > I also suspect, the pins on the back connector are USB UDC, not UHC
> > > > ... aka. the hardware has no UHC.
> > > 
> > > They are UHC, check http://www.mozzwald.com/node/60
> > 
> > So it is compliant or is it a hack ?
> 
> PXA27x has OHCI (check datasheet), and it's wired to expansion connector,
> so you can use it with self-powered USB devices (Zipit Z2 provides only
> 3.3V on expansion connector). It's definitely not a hack.

This doesn't make me believe it's compliant. Besides, iirc the zipit hardware 
wiki says it's only meant for UDC. The fact you can reconfigure it for UHC and 
use it with a limited amount of devices if you're lucky makes me feel it's so 
much of a hack.

> 
> Regards
> Vasily
