From: matija.glavinic-pecotic.ext@nokia.com (Matija Glavinic Pecotic)
Date: Mon, 16 May 2016 22:29:59 +0200
Subject: [PATCH] ARM: Fix A15 798181 errata initialization
In-Reply-To: <20160516162757.GA29346@localhost.localdomain>
References: <5734FA64.6040501@nokia.com>
 <20160516162757.GA29346@localhost.localdomain>
Message-ID: <573A2DC7.8080901@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2016 06:27 PM, EXT Catalin Marinas wrote:
> The errata documents haven't been updated yet but my reading of the
> corresponding ARM support case is that the "REVIDR[9] set" case only
> refers to r2p4. It should be a safe assumption for r3pX as well since
> REVIDR[9] is an update to the previous REVIDR[4] ECO. Anyway, I asked
> ARM support for clarification and get back to you.

I see it possible for at least r3p3 as well since there revidr[4] is reserved. But yes, more clarification is for sure welcomed.

BTW, I do not know which support case you refer to.

> Please add the rXpY ranges and corresponding REVIDR combinations to the
> comment above. It makes it easier to read the code later without having
> to dig into the commit logs.

Ok, will do.

Thanks,

Matija
