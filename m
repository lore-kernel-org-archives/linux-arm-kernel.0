From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Sun, 06 May 2012 18:50:16 +0300
Subject: [PATCH] omap: dma: Clear status registers on enable/disable irq.
In-Reply-To: <1633215.yCrxk1mQVq@acer>
References: <1334954578-10478-1-git-send-email-oleg.matcovschi@ti.com>
 <20120504165146.GB5613@atomide.com> <1633215.yCrxk1mQVq@acer>
Message-ID: <4FA69DB8.7060000@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2012 10:39 PM, Janusz Krzysztofik wrote:
>> This seems like a nice fix to me. As it affects all omaps, I'd like to
>> see some tested-by from Janusz/Jarkko/Peter. Can you guys give it a 
> try
>> with some audio tests?
> 
> OK, I can do, but perhaps not before next Saturday, when I'm back home, 
> able to actually listen to the audio, not only watch the IRQ counters 
> rising up ;-).
> 
Ok from omap3

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
