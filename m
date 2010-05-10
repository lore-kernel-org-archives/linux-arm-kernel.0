From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Mon, 10 May 2010 17:27:22 +0300
Subject: S3C6410 power management support status
In-Reply-To: <20100510023537.GW26401@trinity.fluff.org>
References: <20100429124509.GA11290@jeknote.loshitsa1.net>
	<20100504002420.GQ6684@trinity.fluff.org>
	<20100506144955.GA24641@jeknote.loshitsa1.net>
	<20100510023537.GW26401@trinity.fluff.org>
Message-ID: <20100510142721.GA32413@jeknote.loshitsa1.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 03:35:37AM +0100, Ben Dooks wrote:
> > Can anybody check suspend mode with SMDK6410 and confirm that StR works
> > on it? If it works, we will stop to ask stupid questions and will find
> > our hardware bugs :)
> 
> It does seem to work on this SMDK, and the XPWRTGON line on TP7 definetly
> goes low during sleep.
> 
> Note, not sure if I will post the buttons patches as the SMDK's single
> buttons share interrupts with the LAN and other devices, making them
> rather useless (my SMDK6410 has EINT10 held permanently active by the
> unused network devices...)

Thanks for your help. Last question: which U-Boot (or another
bootloader) you use?

-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek at jabber.ru

A: No
Q: Should I quote below my post?
