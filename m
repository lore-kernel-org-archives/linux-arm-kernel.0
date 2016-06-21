From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Jun 2016 09:55:17 +0100
Subject: [GIT PULL] drivers: firmware: scpi updates for v4.8
In-Reply-To: <20160621055247.GC24293@localhost>
References: <5768022D.2010506@arm.com> <20160621055247.GC24293@localhost>
Message-ID: <576900F5.5090907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/06/16 06:52, Olof Johansson wrote:
> On Mon, Jun 20, 2016 at 03:48:13PM +0100, Sudeep Holla wrote:
>> Hi ARM-SoC team,
>>
>> Here are few updates for SCPI drivers for v4.8. The DT binding have been
>> ACKed by DT maintainer.
>>
>> Also as most of the genpd code is in drivers/soc and SCPI can be used on
>> any SoC, runtime PM maintainer agreed to keep the SCPI genpd based power
>> domain driver in drivers/firmware for now. It also carries their
>> ACK.
>
> Am I missing something here? The only Acked-by I see on any patch is the one
> from Mark Rutland on the bindings.
>

Ah sorry by mad for misleading. Ulf reviewed and provided Reviewed-by tag.

Also Kevin H provided Reviewed-by with couple of minor nits to be fixed
last evening. I will fix them and re-spin this pull request.

Since they agreed to keep it in drivers/firmware, I assume that's whey
no acks but just Reviewed-by.

Thanks for the patience.

-- 
Regards,
Sudeep
