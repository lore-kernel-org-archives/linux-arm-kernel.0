From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 18:57:33 -0700
Subject: [PATCH] ARM: at91/dt: sama5d4: fix dma conf for aes,
 sha and tdes nodes
In-Reply-To: <5576BBFD.2060605@atmel.com> (Nicolas Ferre's message of "Tue, 9
 Jun 2015 12:12:13 +0200")
References: <1433771754-4999-1-git-send-email-ludovic.desroches@atmel.com>
 <5576BBFD.2060605@atmel.com>
Message-ID: <7h8ubrgg6q.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> Le 08/06/2015 15:55, Ludovic Desroches a ?crit :
>> The xdmac channel configuration is done in one cell not two. This error
>> prevents from probing devices correctly.
>> 
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>> Fixes: 83906783b766 ("ARM: at91/dt: sama5d4: add aes, sha and tdes nodes")
>> Cc: stable at vger.kernel.org # 4.1
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Arnd, Olof, Kevin,
>
> This patch is a fix concerning material that had been added to 4.1, so
> it's not exactly a regression.
>
> So, as we missed the last train to 4.1, I'd like to queue it for 4.2 but
> it's the only patch I have on top of my previous DT pull-request
> (at91-dt4, not taken by you, yet).
>
> So, should I build another pull-request (at91-dt5) or can you take this
> single patch when you pull the at91-dt4 material?

I've applied it to next/dt after pulling your dt4 series.

> BTW, here is the link to patchwork if it's easier:
> https://patchwork.kernel.org/patch/6565591/

Yes, that's helpful.  I'm a big fan of 'pwclient git-am', and patchwork
collects acks automatically as well. :)

Thanks,

Kevin
