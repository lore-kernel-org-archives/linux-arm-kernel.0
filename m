From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 Oct 2012 20:37:45 +0200
Subject: Which kirkwood does your DT board use?
In-Reply-To: <5085BA54.6050006@baker-net.org.uk>
References: <20121020113800.GC21046@lunn.ch>
 <5085BA54.6050006@baker-net.org.uk>
Message-ID: <20121023183745.GW21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 10:27:48PM +0100, Adam Baker wrote:
> On 20/10/12 12:38, Andrew Lunn wrote:
> >Hi Folks
> >
> >All of you in the To: have contributed a DT based Kirkwood board port.
> >Nearly all the DT files we have declare the CPU to be
> >marvell,kirkwood-88f6281. For adding DT based pinctrl, to replace the
> >mpp code, we need to know the exact kirkwood being used. It should be
> >one of MV88F6180, MV88F6190, MV88F6192, MV88F6281 or MV88F6282.
> >
> >You can see what your hardware has a boot time:
> >
> >Kirkwood: MV88F6282-Rev-A0, TCLK=200000000.
> >
> >Please could you check your hardware and let me know what the correct
> >CPU is. I can then fix the .dts files and prepare a first attempt at
> >converting boards to pinctrl.
> >
> 
> Hi,
> 
> I've not seen a reply from Arnaud yet so I'll offer
> 
> Iomega Iconnect
> Kirkwood: MV88F6281-A0, TCLK=200000000.

Hi Adam

Thanks. Arnaud replied p-t-p.

I'm was missing just one reply, but with a bit of googling, i found a
boot log online, so could fill the gap.

kirkwood-dns320.dts	     MV88F6281
kirkwood-dns325.dts	     MV88F6281
kirkwood-dockstar.dts	     MV88F6281
kirkwood-dreamplug.dts	     MV88F6281
kirkwood-goflexnet.dts	     MV88F6281
kirkwood-ib62x0.dts	     MV88F6281
kirkwood-iconnect.dts	     MV88F6281
kirkwood-iomega_ix2_200.dts  MV88F6281
kirkwood-lschlv2.dts	     MV88F6281
kirkwood-lsxhl.dts	     MV88F6281
kirkwood-ts219-6281.dts      MV88F6281
kirkwood-ts219-6282.dts      MV88F6282

Not what i was expecting, nearly every one being 6281!
But it does mean there are no DT files to correct :-)

Thanks for your answers everybody.

       Andrew
