From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Jul 2014 09:15:43 -0700
Subject: [PATCH] ARM: at91: at91sam9x5: add clocks for usb device
In-Reply-To: <1405096496-4139-1-git-send-email-nicolas.ferre@atmel.com>
References: <1405096496-4139-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20140712161543.GA3107@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 06:34:56PM +0200, Nicolas Ferre wrote:
> From: Bo Shen <voice.shen@atmel.com>
> 
> Add clocks for usb device, or else switch to CCF, the gadget
> won't work.
> 
> Reported-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Tested-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Arnd, Olof, Kevin,
> 
> This fix is the only one that I have for 3.16-rc currently. Can you please
> take it as a patch and queue it? It can go on top of already sent AT91 fixes
> for 3.16 or a 3.16-rc4.

Certainly. Appled to fixes now.


-Olof
