From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 17 Nov 2018 21:14:40 +0100
Subject: [PATCH] ARM: dts: pxa3xx: Add Raumfeld DTS files
In-Reply-To: <87in14lkzp.fsf@belgarion.home> (Robert Jarzmik's message of
 "Sat, 10 Nov 2018 21:45:46 +0100")
References: <20181105194040.25406-1-daniel@zonque.org>
 <87in14lkzp.fsf@belgarion.home>
Message-ID: <87pnv3ihqn.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Daniel Mack <daniel@zonque.org> writes:
>
>> This patch adds a set of DTS files that support all PXA3xx based Raumfeld
>> audio hardware devices.
>>
>> Common nodes are factored out into 'common' and 'tuneable-clock' include
>> files to keep the top-level DTS files smaller.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
> Hi Daniel,
>
> I will need someone from the devicetree to ack this one, Rob or anybody
> maintaining the devicetree.

Rob, Mark, would you be so kind as to have a look at this patch, I have no
concerns taking it into the pxa/dt tree, but I'd rather be safe with someone
from the devicetree maintainers reviewing it first.

Cheers.

-- 
Robert
