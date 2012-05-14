From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Mon, 14 May 2012 14:48:31 +0200
Subject: [PATCH] omap: dma: Clear status registers on enable/disable irq.
In-Reply-To: <4FA69DB8.7060000@bitmer.com>
References: <1334954578-10478-1-git-send-email-oleg.matcovschi@ti.com>
 <1633215.yCrxk1mQVq@acer> <4FA69DB8.7060000@bitmer.com>
Message-ID: <5693144.pkJCBoTAMO@vclass>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 06 of May 2012 18:50:16 Jarkko Nikula wrote:
> On 05/04/2012 10:39 PM, Janusz Krzysztofik wrote:
> >> This seems like a nice fix to me. As it affects all omaps, I'd like to
> >> see some tested-by from Janusz/Jarkko/Peter. Can you guys give it a 
> > try
> >> with some audio tests?
> > 
> > OK, I can do, but perhaps not before next Saturday, when I'm back home, 
> > able to actually listen to the audio, not only watch the IRQ counters 
> > rising up ;-).
> > 
> Ok from omap3
> 
> Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Works for me on OMAP1.

Tested-by: Janusz Krzyszofik <jkrzyszt@tis.inet.pl>
