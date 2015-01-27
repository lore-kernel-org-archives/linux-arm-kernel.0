From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 27 Jan 2015 05:42:44 +0100
Subject: [GIT PULL RESEND] pxa for v3.20
References: <87egqpff9m.fsf@free.fr> <20150123215423.GD20896@quad.lixom.net>
 <874mrgdzz0.fsf@free.fr> <20150127021733.GB22154@quad.lixom.net>
Message-ID: <87lhkoq1ff.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> writes:

> I had already merged, but it looks like you broke viper and zeus. Both of them
> still refer to PXA_ISA_IRQ().
>
> Can you send an incremental patch for that? Or if you prefer that we drop this
> branch for now while you sort it out that's OK too -- your preference.
I'll send an incremental patch.
I'm really frustrated my bot didn't catch that, I suppose yours caught it by
building viper_defconfig ...

> Yeah we normally scale this by educating downstream maintainers. checkpatch is
> useful in many cases but making it do everything is hard.
Yeah, but humans do forget, even educated ... I'll be carefull as much as I can,
but I knew the rule and yet this slipped through.

Cheers.

-- 
Robert
