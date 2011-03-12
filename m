From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 12 Mar 2011 14:28:40 +0100
Subject: [PATCH v2 2/8] ARM: PXA: Z2: Enable OHCI on Zipit Z2
In-Reply-To: <201103121332.22136.anarsoul@gmail.com>
References: <1299839023-16601-2-git-send-email-anarsoul@gmail.com>
	<201103120107.58907.marek.vasut@gmail.com>
	<201103121332.22136.anarsoul@gmail.com>
Message-ID: <201103121428.40368.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 12:32:21 Vasily Khoruzhick wrote:
> On Saturday 12 March 2011 02:07:58 Marek Vasut wrote:
> > > AFAIK UDC pins are separate from UHC, so you can't use it as UDC. If
> > > I'm wrong, please correct me. Because UDC on Zipit is much more
> > > usefull for me than UHC :)
> > 
> > Check datasheet, they're likely the same pins.
> 
> I still see no reason to drop this patch - USB host works pretty well on
> Zipit Z2.

http://esd.cs.ucr.edu/webres/usb11.pdf try reading for example here. The 
discussion's getting into loop, so I'm pulling out. Someone else should comment 
on this too.

> 
> Regards
> Vasily
