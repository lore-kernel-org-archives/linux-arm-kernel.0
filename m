From: ada@thorsis.com (Alexander Dahl)
Date: Thu, 31 Aug 2017 08:27:40 +0200
Subject: [PATCH v2 2/7] memory: atmel-ebi: Simplify SMC config code
In-Reply-To: <7c857a5fb2c61109d5db9e185f60741a@dedf.co.uk>
References: <7c857a5fb2c61109d5db9e185f60741a@dedf.co.uk>
Message-ID: <16716411.UiFsKmejXl@ada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ian,

Am Mittwoch, 30. August 2017, 13:53:57 schrieb ian.eperson at dedf.co.uk:
> My understanding is that atmel_ebi_xslate_smc_timings() returns true
> (>0), false (0) or error (<0) so the first test here should be:
> 
> 	if(ret<0)

I came to the same conclusions in July and sent a patch which was 
already applied with commit bc9b934b2fbbd51008a1b52c0cd1b457e6440736 on 
master.

Greets
Alex
