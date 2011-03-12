From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 12 Mar 2011 13:32:21 +0200
Subject: [PATCH v2 2/8] ARM: PXA: Z2: Enable OHCI on Zipit Z2
In-Reply-To: <201103120107.58907.marek.vasut@gmail.com>
References: <1299839023-16601-2-git-send-email-anarsoul@gmail.com>
	<201103120034.18406.anarsoul@gmail.com>
	<201103120107.58907.marek.vasut@gmail.com>
Message-ID: <201103121332.22136.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 02:07:58 Marek Vasut wrote:

> > AFAIK UDC pins are separate from UHC, so you can't use it as UDC. If I'm
> > wrong, please correct me. Because UDC on Zipit is much more usefull for
> > me than UHC :)
> 
> Check datasheet, they're likely the same pins.

I still see no reason to drop this patch - USB host works pretty well on Zipit 
Z2.

Regards
Vasily
