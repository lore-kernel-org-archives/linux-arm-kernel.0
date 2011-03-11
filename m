From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 11 Mar 2011 22:51:25 +0100
Subject: [PATCH 6/8] ARM: PXA: Z2: Fix libertas init/tear down sequences
In-Reply-To: <201103112341.27439.anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<201103112237.43566.marek.vasut@gmail.com>
	<201103112341.27439.anarsoul@gmail.com>
Message-ID: <201103112251.25358.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 22:41:27 Vasily Khoruzhick wrote:
> On Friday 11 March 2011 23:37:43 Marek Vasut wrote:
> > On Friday 11 March 2011 11:23:41 Vasily Khoruzhick wrote:
> > > GPIO15 seems to be not related to WiFi, so don't touch it.
> > 
> > What's GPIO14 then? Also check Z2 kernel sources aeronix released, iirc
> > that's where I found gpio14.
> > 
> > Cheers
> 
> Don't know what it is, but according to my investigations via qemu (I added
> traces on gpio access), stock kernel does not touch this gpio at all.

So be it then.

> 
> Regards
> Vasily
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
