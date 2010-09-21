From: stephan@gatzka.org (Stephan Gatzka)
Date: Tue, 21 Sep 2010 18:54:55 +0200
Subject: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
In-Reply-To: <20100906063327.GA4549@riccoc20.at.omicron.at>
References: <363bd749a38d0b785d8431e591bf54c38db4c2d7.1281956490.git.richard.cochran@omicron.at>	<AANLkTik_2MKMhOuDGOmu8Kzyq-ipLe+Bxrb3FaD+Tv4U@mail.gmail.com>	<20100817085324.GB3330@riccoc20.at.omicron.at>	<1282090963.1734.97.camel@localhost>	<20100818071942.GA4096@riccoc20.at.omicron.at>	<1282176776.2865.100.camel@localhost.localdomain>	<20100819055518.GA4084@riccoc20.at.omicron.at>	<1282594125.3111.344.camel@localhost.localdomain>	<20100827123849.GC11657@riccoc20.at.omicron.at>	<1282948239.2268.155.camel@jstultz-laptop>
	<20100906063327.GA4549@riccoc20.at.omicron.at>
Message-ID: <4C98E35F.6050207@gatzka.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

> 1. Character device
> 2. POSIX clock with dynamic ids
>
> Please, just take your pick ;^)

Just to reopen this nearly dead but very interesting thread: I'm happy 
with every solution that has no impact on the accuracy of the PTP clock.

If I can choose, I would prefer the POSIX clock with dynamic ids solution.

Kind regards and thanks for your effort,

Stephan Gatzka

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5136 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100921/26b61410/attachment.p7s>
