From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Wed, 03 Oct 2012 15:51:23 +0200
Subject: [RESEND][PATCH] ASoC: ams-delta: Convert to use
 snd_soc_register_card()
In-Reply-To: <1582731.dIkBtAuyKn@vclass>
References: <20120906073633.GC22330@opensource.wolfsonmicro.com>
 <1582731.dIkBtAuyKn@vclass>
Message-ID: <6691562.6MvWD9K1dk@vclass>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,
Please note we have an Ack from Tony.
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-September/055493.html

Thanks,
Janusz

---
Subject: Re: [PATCH] ASoC: ams-delta: Convert to use snd_soc_register_card()
Date: niedziela, 16 wrze?nia 2012, 13:44:23
From: Tony Lindgren <tony@atomide.com>
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, linux-omap at vger.kernel.org, linux-arm-kernel at lists.infradead.org, alsa-devel at alsa-project.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [120916 12:18]:
> 
> Tony,
> Please give your ack on the arch/arm/mach-omap1 bits if acceptable. I
> believe there should be no merge conflicts if this change goes through
> sound/soc.

Yes looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
