From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Feb 2011 15:24:25 +0000
Subject: [PATCH -next] ALSA: AACI: fix crash in aaci_size_fifo
In-Reply-To: <1297092139.11987.29.camel@e102391-lin.cambridge.arm.com>
References: <1297091227-27142-1-git-send-email-marc.zyngier@arm.com>
	<20110207151313.GA5853@n2100.arm.linux.org.uk>
	<1297092139.11987.29.camel@e102391-lin.cambridge.arm.com>
Message-ID: <20110207152425.GB5853@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 03:22:19PM +0000, Marc Zyngier wrote:
> On Mon, 2011-02-07 at 15:13 +0000, Russell King - ARM Linux wrote:
> > On Mon, Feb 07, 2011 at 03:07:07PM +0000, Marc Zyngier wrote:
> > > As this is probably only a debug leftover, get rid of the statement altogether.
> > 
> > No.  Reading back from the register makes sure that the write hits the device
> > before we delay.
> > 
> 
> Right. Something like that?

Yes which is what I've already changed it to.
