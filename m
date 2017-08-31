From: ian.eperson@dedf.co.uk (ian.eperson at dedf.co.uk)
Date: Thu, 31 Aug 2017 10:39:49 +0100
Subject: [PATCH v2 2/7] memory: atmel-ebi: Simplify SMC config code
In-Reply-To: <16716411.UiFsKmejXl@ada>
References: <7c857a5fb2c61109d5db9e185f60741a@dedf.co.uk>
 <16716411.UiFsKmejXl@ada>
Message-ID: <5a385961d7c4bcdf38f1e26d508f79af@dedf.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex

Apologies, I obviously wasn?t looking close enough to the leading edge.

I notice your patch also picks up on the Copy/Paste typo on line 75 of 
atmel-ebi.c which I'd just spotted:

	atmel_smc_cs_conf_set_setup -> atmel_smc_cs_conf_set_cycle

I'll go back to getting my head round the smc, ebi, ahb hierarchy in 
the device tree.

Regards



Ian Eperson
DeDf Co Ltd
