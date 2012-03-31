From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 01 Apr 2012 01:23:30 +0400
Subject: [PATCH] ARM: at91: Export at91_ramc_base
In-Reply-To: <4f761fd8.8843cc0a.22b0.6caa@mx.google.com>
References: <4f761fd8.8843cc0a.22b0.6caa@mx.google.com>
Message-ID: <4F7775D2.7050608@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 31-03-2012 1:03, manabian at gmail.com wrote:

> From: Joachim Eastwood<joachim.eastwood@jotron.com>

> After commit f363c407b42c4 building at91_cf as a module fails with:

    Please also specify that commit's summary in parens.

>    ERROR: "at91_ramc_base" [drivers/pcmcia/at91_cf.ko] undefined!
>    make[1]: *** [__modpost] Error 1
>    make: *** [modules] Error 2

> Export at91_ramc_base symbol to allow drivers using at91_ramc_*
> functions to be built as modules again.

> Signed-off-by: Joachim Eastwood<joachim.eastwood@jotron.com>

WBR, Sergei
