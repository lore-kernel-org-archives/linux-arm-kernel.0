From: metan@ucw.cz (Cyril Hrubis)
Date: Fri, 15 Apr 2011 23:38:17 +0200
Subject: Zaurus CF tests -- ok
In-Reply-To: <20110415211822.GB21111@atrey.karlin.mff.cuni.cz>
References: <20110415211822.GB21111@atrey.karlin.mff.cuni.cz>
Message-ID: <20110415213817.GC4420@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> After getting _good_ power supply, I was able to untar and rm ltp tree
> 100 times so far. 2.6.38, ext3. (So metan no, I do not see any weird
> ext3 problems).

Hmm, I'm using original adapter, but who knows if it's okay to use...

> Another strange thing is... I see lots of duplicated keystrokes --
> like type "pavel" but machine understands "paavel". But it only seems
> to happen when I'm _not_ trying to debug it?!

That seems to be side effect of machine under load (it has gpio keyboard).

> (
> So... just because something needs 5V does not mean you should charge
> it from USB.
> 
> Yes, I'm talking about zaurus. I noticed that it crashed rather
> quickly when connected to USB power. (For example in tar/rm test).
> So I took multimeter, and there was 4.15..4.5V on USB :-(.
> 
> With power from USB extension cable, it crashes in <5 minutes. It
> seems to toggle charger a lot, as voltage on the cable is only
> 4.2..4.5V. I guess it is software problem in the charging code.
> )

The zaurus actually is AFAIK unable to run from battery when connected to the
external power, so weak power line may explain some of the strange behaviour.

-- 
metan
