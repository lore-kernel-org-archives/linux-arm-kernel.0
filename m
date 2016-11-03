From: romain.perier@free-electrons.com (Romain Perier)
Date: Thu, 3 Nov 2016 14:57:06 +0100
Subject: [crypto] [marvell-cesa] Possible regression after Linux 4.7
In-Reply-To: <58174e5d.233ac20a.a4335.5656@mx.google.com>
References: <58174e5d.233ac20a.a4335.5656@mx.google.com>
Message-ID: <4573998d-6c5b-03e4-e1fa-7516d5a9e276@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le 31/10/2016 ? 14:59, radioconfusion at gmail.com a ?crit :

> Do you have any improvement for the issue?
> Please let me know if you need any help to resolve it.
>
> Best Regards,
> Jussi
>

Sorry for the delay.
Could you try to revert locally commit 
2786cee8e50bb4b4303dc22665f391b72318fa84 (crypto: marvell - Move SRAM 
I/O operations to step functions) ?

It seems to fix most of the issues I had with curl.
I will continue to investigate, that's just to confirm if it fixes the 
issues for you.

Thanks,
Romain
-- 
Romain Perier, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
