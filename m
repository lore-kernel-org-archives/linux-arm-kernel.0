From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 11 May 2010 01:20:01 +0100
Subject: S3C6410 power management support status
In-Reply-To: <20100510142721.GA32413@jeknote.loshitsa1.net>
References: <20100429124509.GA11290@jeknote.loshitsa1.net>
	<20100504002420.GQ6684@trinity.fluff.org>
	<20100506144955.GA24641@jeknote.loshitsa1.net>
	<20100510023537.GW26401@trinity.fluff.org>
	<20100510142721.GA32413@jeknote.loshitsa1.net>
Message-ID: <20100511002001.GZ26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 05:27:22PM +0300, Yauhen Kharuzhy wrote:
> On Mon, May 10, 2010 at 03:35:37AM +0100, Ben Dooks wrote:
> > > Can anybody check suspend mode with SMDK6410 and confirm that StR works
> > > on it? If it works, we will stop to ask stupid questions and will find
> > > our hardware bugs :)
> > 
> > It does seem to work on this SMDK, and the XPWRTGON line on TP7 definetly
> > goes low during sleep.
> > 
> > Note, not sure if I will post the buttons patches as the SMDK's single
> > buttons share interrupts with the LAN and other devices, making them
> > rather useless (my SMDK6410 has EINT10 held permanently active by the
> > unused network devices...)
> 
> Thanks for your help. Last question: which U-Boot (or another
> bootloader) you use?

The uboot supplied on this SMDK.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
