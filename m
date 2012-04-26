From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Apr 2012 19:07:19 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120404111524.GF32505@mudshark.cambridge.arm.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com>
 <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
 <20120403094749.GH17741@mudshark.cambridge.arm.com>
 <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
 <20120403123444.GL17741@mudshark.cambridge.arm.com>
 <878vicsxef.fsf@ti.com>
 <20120403160706.GP17741@mudshark.cambridge.arm.com>
 <87ehs4pfw4.fsf@ti.com>
 <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
 <20120404111524.GF32505@mudshark.cambridge.arm.com>
Message-ID: <20120426180719.GC20186@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 12:15:24PM +0100, Will Deacon wrote:
> On Wed, Apr 04, 2012 at 12:29:49AM +0100, Paul Walmsley wrote:
> > 
> > Part of the problem is that the clockdomain data for the emu_sys 
> > clockdomain is wrong.  Here's something to try to fix it.  It might just 
> > be enough to get it to work.
> 
> Hmm, doesn't seem to work but I do see the following in dmesg when I try to
> use perf:
> 
>  powerdomain: waited too long for powerdomain emu_pwrdm to complete transition
> 
> which is new with your patch.

Sorry to nag, but does anybody have a clue where to go from here? I can
start digging in the OMAP PM code, but it's all new territory for me.

Cheers,

Will
