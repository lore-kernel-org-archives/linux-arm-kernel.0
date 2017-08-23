From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 23 Aug 2017 21:33:44 +0200
Subject: [PATCH v5 0/9] mtd: sharpslpart partition parser
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
 <20170821221339.70cfcfb7@bbrezillon>
Message-ID: <87pobmoz8n.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> Le Mon, 14 Aug 2017 22:48:31 +0200,
>> Andrea Adami (9):
>>   mtd: sharpslpart: Add sharpslpart partition parser
>>   mtd: nand: sharpsl: Add partition parsers platform data
>>   mfd: tmio: Add partition parsers platform data
>>   mtd: nand: sharpsl: Register partitions using the parsers
>>   mtd: nand: tmio: Register partitions using the parsers
>
> Applied patches 2, to 5 to nand/next.
>>   ARM: pxa/corgi: Remove hardcoded partitioning, use sharpslpart parser
>>   ARM: pxa/tosa: Remove hardcoded partitioning, use sharpslpart parser
>>   ARM: pxa/spitz: Remove hardcoded partitioning, use sharpslpart parser
>>   ARM: pxa/poodle: Remove hardcoded partitioning, use sharpslpart parser

I'm quite happy with patches 6 to 9 except for the subject title length.

Andrea, if you give me an idea of change, I'll modify the titles myself before
applying, no need to resend a serie.

For example, you could propose :
ARM: pxa: corgi: use sharpslpart parser instead of hardcoded one


Then I'll take them into pxa/for-next if there are no objections.

Cheers.

-- 
Robert
