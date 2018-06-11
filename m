From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 11 Jun 2018 21:54:12 +0200
Subject: [RESEND v2] dmaengine: pxa: add a default requestor policy
In-Reply-To: <20180611042125.GD2452@vkoul-mobl> (Vinod Koul's message of "Mon,
 11 Jun 2018 09:51:25 +0530")
References: <20180530201249.26972-1-robert.jarzmik@free.fr>
 <878t7oruya.fsf@belgarion.home> <20180611042125.GD2452@vkoul-mobl>
Message-ID: <8736xtrtej.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@linaro.org> writes:

> On 09-06-18, 14:43, Robert Jarzmik wrote:
>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>> 
>> > As what former drcmr -1 value meant, add a this as a default to each
>> > channel, ie. that by default no requestor line is used.
>> >
>> > This is specifically used for network drivers smc91x and smc911x, and
>> > needed for their port to slave maps.
>> >
>> > Cc: Arnd Bergmann <arnd@arndb.de>
>> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> > ---
>> > Since v1: changed -1 to U32_MAX
>> Hi Vinod,
>> 
>> Could I have your ack on this so that I add this one to the dma slave map serie
>> after the merge window is closed please ?
>
> Sorry I was thinking it would go thru dmaengine tree, please do
> indicate if that is not the case. Nevertheless
>
> Acked-by: Vinod Koul <vkoul@kernel.org>
Thanks.

As this is a dependency to the serie, I'd rather take it, unless you insist, in
which case I'll rely on the fact that it will hit 4.19 cycle.

Cheers.

-- 
Robert
