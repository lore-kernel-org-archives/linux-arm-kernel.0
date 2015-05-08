From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Fri, 8 May 2015 14:17:25 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <20150508111048.GE2067@n2100.arm.linux.org.uk>
References: <5538DD02.6050401@topic.nl> <3382997.5hgfVKmNXP@wuerfel>
 <5540D356.50708@topic.nl> <9622793.RaVBbeJMCx@wuerfel>
 <554B49F0.1090100@topic.nl>
 <CAD8Lp45w6_ck13sG3PQ549AxsgTi96XQAkUEd9DQqt-i=ZXxUQ@mail.gmail.com>
 <554B6917.40705@topic.nl> <554B71F6.5000106@topic.nl>
 <20150507143010.GC2067@n2100.arm.linux.org.uk> <554C4FCE.6070802@topic.nl>
 <20150508111048.GE2067@n2100.arm.linux.org.uk>
Message-ID: <554CA955.4020205@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 08-05-15 13:10, Russell King - ARM Linux wrote:
> Well, I do find the language used rather loose.  The term "coherent" is
> well understood, but when the documentation mixes it with "consistent"
> it becomes less clear whether the two terms mean the same thing or
> something different.

I re-read https://www.kernel.org/doc/Documentation/DMA-API.txt with this in mind.

"Part Ia" starts with "dma_alloc_coherent" and (friends) but then talks about 
"consistent" memory throughout the whole part. I think a 
s/consistent/coherent/g in this part will make things a lot clearer for everyone.

Shall I submit a patch for that?

Part Ib continues, but switches to using the word "coherent" instead.




Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
