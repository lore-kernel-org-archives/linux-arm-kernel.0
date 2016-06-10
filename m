From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 10 Jun 2016 14:49:36 +0200
Subject: [PATCH] ARM: orion: remove unreferenced board-d2net.c
In-Reply-To: <20160609163608.GA23507@lunn.ch>
References: <1465466656-30002-1-git-send-email-ben.dooks@codethink.co.uk>
 <20160609133116.GH30205@lunn.ch>
 <20160609153935.44323b8e@free-electrons.com>
 <20160609141006.GK30205@lunn.ch>
 <20160609161215.084e06f1@free-electrons.com>
 <d521ce93-f647-0c6f-89f5-aeffd82b87e1@codethink.co.uk>
 <20160609163608.GA23507@lunn.ch>
Message-ID: <20160610124936.GD16054@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 06:36:08PM +0200, Andrew Lunn wrote:
> On Thu, Jun 09, 2016 at 04:52:35PM +0100, Ben Dooks wrote:
> > On 09/06/16 15:12, Thomas Petazzoni wrote:
> > > Hello,
> > > 
> > > On Thu, 9 Jun 2016 16:10:06 +0200, Andrew Lunn wrote:
> > > 
> > >>> That being said, this has been broken more than 2 years ago, and nobody
> > >>> noticed. Doesn't this mean that we could get rid of the support for
> > >>> this board entirely? :)  
> > >>
> > >> Well, all it means is the LEDs don't blink. If the disk was not
> > >> spinning, or the ethernet device missing, i would agree with you. But
> > >> somebody could be using this device and don't notice the difference
> > >> with the LEDs.
> > 
> > Surely DT can manage blinking LEDs??
> 
> There is an additional GPIO needed. However, i think a pin hog should
> allow this to be represented in DT. Two years ago, i don't think this
> sort of hogging existed.

I think this LED device is compatible with the leds-ns2 driver. If it is
true, then the LED definition can be moved into the DT file. I'll look
at that.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/9c5e9e8c/attachment.sig>
