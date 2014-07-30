From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 30 Jul 2014 10:58:08 +0800
Subject: [PATCHv2 2/3] ARM: dts: vf610-twr: Add PWM0's pinctrl node
In-Reply-To: <4eb97d0849cd4a4787d8405df7391816@BN1PR0301MB0609.namprd03.prod.outlook.com>
References: <1395627736-5338-1-git-send-email-Li.Xiubo@freescale.com>
 <1395627736-5338-3-git-send-email-Li.Xiubo@freescale.com>
 <8738dkuh7a.fsf@nbsps.com>
 <4eb97d0849cd4a4787d8405df7391816@BN1PR0301MB0609.namprd03.prod.outlook.com>
Message-ID: <20140730025807.GC10206@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 10:11:48AM +0800, Xiubo Li-B47053 wrote:
> > I think it might be valuable to add the
> > 'ttyLP2' to the vf610-twr.  An MMC image could echo 'wrong serial port,
> > set J23/24' for instance to tell people that the serial console was not
> > connected properly (or something else).  People may also wish to use a
> > serial interface for other peripherals or as a 2nd debug port.
> > 
> 
> Hum, if so I think it's okay.
> 
> @Shawn,
> 
> Do you have any comments here ?

I'm fine with leaving the pins to serial interface, if it makes the most
sense to most people, which sounds like the case from your discussion.

Shawn
