From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Fri, 13 Oct 2017 09:01:19 +0200
Subject: [PATCH 16/16] arm64: dts: marvell: armada-3720-espressobin:
 fill UART nodes
In-Reply-To: <87zi8wbocl.fsf@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
 <20171006101344.15590-17-miquel.raynal@free-electrons.com>
 <87fuawe8gx.fsf@free-electrons.com>
 <20171006151521.440418a2@windsurf.lan>
 <20171009093025.78d45a9a@xps13> <87zi8wbocl.fsf@free-electrons.com>
Message-ID: <20171013090119.44e9a3c5@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gregory,

On Thu, 12 Oct 2017 13:24:42 +0200
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Miquel,
>  
>  On lun., oct. 09 2017, Miquel RAYNAL
> <miquel.raynal@free-electrons.com> wrote:
> 
> > Hi Thomas, Gregory,
> >
> > On Fri, 6 Oct 2017 15:15:21 +0200
> > Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> >  
> >> Hello,
> >> 
> >> On Fri, 06 Oct 2017 15:01:18 +0200, Gregory CLEMENT wrote:
> >>   
> >> >  /*
> >> >   * To enable the second UART on J17 (pins 24,26) refer to the
> >> > uart1
> >> >   * node from armada-3720-db.dts.
> >> >   * Note that TX and RX signal are the ones coming directly from
> >> > the SoC:
> >> >   * 1.8V TTL.
> >> >   */    
> >> 
> >> One issue with this comment (and Miqu?l's version as well) is that
> >> it does not explain why you don't enable this UART by default.
> >> 
> >> The real reason is in the commit log from Miqu?l, and should
> >> probably be part of the comment. Perhaps something like:
> >> 
> >> /*
> >> 
> >>  * Connector J17 (pins X, Y, Z) exposes a number of different
> >>  * features:
> >>  *  - UART1 (pins 24 = RX, pins 26 = TX), see armada-3720-db.dts
> >> for an
> >>  *    example on how to enable UART1. Beware that the signals are
> >> 1.8V
> >>  *    TTL.
> >>  *  - SPIxyz
> >>  *  - I2Cxyz
> >>  */  
> >
> > Thanks for both your comments, there is my version, inspired from
> > both comments:
> >
> > /*
> >  * Connector J17 exposes a number of different features. Some pins
> > are
> >  * multiplexed. This is the case for the UART1 feature (pins 24 =
> > RX,
> >  * pins 26 = TX). See armada-3720-db.dts for an example of how to
> > enable it.
> >  * Beware that the signals are 1.8V TTL.
> >  */  
> 
> Seems good for me however I prefer Thomas version, easier to read and
> to extend latter with the description of other pins if needed.

Ok, I reused the 'dash' presentation to be later extended.

See v2 coming soon.

Thanks,
Miqu?l

> 
> Gregory
> 
> >
> > Thanks,
> > Miqu?l
> >  
> >> 
> >> Otherwise, it's not clear at all why you don't just enable UART1.
> >> Or perhaps I misunderstood Miqu?l's commit log ?
> >> 
> >> Best regards,
> >> 
> >> Thomas  
> >
> >
> >
> > -- 
> > Miquel Raynal, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com  
> 



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
