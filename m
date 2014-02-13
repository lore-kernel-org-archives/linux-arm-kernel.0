From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 13 Feb 2014 09:54:09 +0100
Subject: [PATCH v4 3/8] at91: dt: Add at91sam9261 dt SoC support
In-Reply-To: <52FC7E0E.2010503@atmel.com>
References: <1392199607-27452-1-git-send-email-jjhiblot@traphandler.com>
 <1392199607-27452-4-git-send-email-jjhiblot@traphandler.com>
 <20140212172844.GE11498@piout.net>
 <CACh+v5MgYB+L6vpektjAE1yTH=dvjnyP1CjJeA7vG_yOyxFkgg@mail.gmail.com>
 <52FC7E0E.2010503@atmel.com>
Message-ID: <20140213085409.GH11498@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/02/2014 at 09:10:54 +0100, Nicolas Ferre wrote :
> On 12/02/2014 20:47, Jean-Jacques Hiblot :
> >>
> >> You probably copied/pasted it but according to the block diagram, the
> >> sdram controller is not under the apb.
> > You're right I copied/pasted :o) But the addresses of the registers
> > look like typical APB addresses.
> > AFAIK all the registers of this SOC are accessed through the APB
> > (except for OHCI and LCDC)
> 
> Yes, that is the point: if the register bank appears as an APB address,
> I place it on the APB bus.
> The other master interfaces (on AHB) are the ones that the IP uses, not
> us from the CPU point of view...
> 
> So I think that Jean-Jacques DT is okay concerning this.
> 


Ok, I'm perfectly fine with that. Thanks for the answer !

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
