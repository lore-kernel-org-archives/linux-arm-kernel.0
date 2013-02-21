From: will.deacon@arm.com (Will Deacon)
Date: Thu, 21 Feb 2013 10:33:43 +0000
Subject: [PATCH] arm: Preserve TPIDRURW on context switch
In-Reply-To: <5125254D.7040401@dawncrow.de>
References: <5112DC7E.4020108@dawncrow.de>
 <20130206225150.GL17833@n2100.arm.linux.org.uk>
 <5112E0C3.1080706@dawncrow.de>
 <20130208154809.GF3495@mudshark.cambridge.arm.com>
 <511A4B93.1000700@dawncrow.de>
 <20130212140950.GC4123@mudshark.cambridge.arm.com>
 <511A5995.5000607@parrot.com> <5125254D.7040401@dawncrow.de>
Message-ID: <20130221103342.GA20566@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Wed, Feb 20, 2013 at 07:34:37PM +0000, Andr? Hentschel wrote:
> Am 12.02.2013 16:02, schrieb Matthieu CASTET:
> > The tls value is never saved to : thread->tp_value[1].
> > 
> > Also I don't know if you can avoid the extra ldr in the software case.
>
> seems like Matthieu is right, any update on this?

Yeah, I'll get round to this after the merge window and send a v2.
I have a nice long flight to Hong Kong on the horizon, which may well drive
me to writing patches :)

Cheers,

Will
