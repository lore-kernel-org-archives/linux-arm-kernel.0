From: albin.tonnerre@free-electrons.com (Albin Tonnerre)
Date: Wed, 30 Sep 2009 14:34:49 +0200
Subject: [PATCH v2] Add cpuidle support for at91
In-Reply-To: <4AC2168B.60903@atmel.com>
References: <1247680190-19674-1-git-send-email-albin.tonnerre@free-electrons.com>
	<200908111200.58866.marc.pignat@hevs.ch>
	<20090812165700.GC4051@pc-ras4041.res.insa>
	<200908130858.47487.marc.pignat@hevs.ch>
	<20090813193241.GA5985@pc-ras4041.res.insa>
	<20090909151417.GA4014@pc-ras4041.res.insa>
	<4AC2168B.60903@atmel.com>
Message-ID: <20090930123449.GB3238@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Moving the discussion to l-a-k at lists.infradead.org]

Salut Nicolas !

Thanks a lot for your answer.

On Tue, 29 Sep 2009 16:15 +0200, Nicolas Ferre wrote :
> Works very well and allow to save some power. After quick measures, we
> run at 172mA at 12V instead of 190mA at 12V so ~2.06W and a saving of ~10% :

... and you haven't tried cpufreq yet :)

> nice job !
> This is of course in my test conditions.

> Just one precision: what is the difference, entering state0 with only
> the current cpu_do_idle() that is activated by default ?

Sorry, I don't get what you mean. Would you mind elaborating a bit?

Regards,
-- 
Albin Tonnerre, Free Electrons
Kernel, drivers and embedded Linux development,
consulting, training and support.
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090930/35313a82/attachment.sig>
