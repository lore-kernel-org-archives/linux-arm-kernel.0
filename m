From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Mar 2011 13:08:33 -0000
Subject: [PATCH] ARM: aout-core: zero thread debug registers in a.out core
	dump
In-Reply-To: <AANLkTin0xzSXRPbTqYkXp+2C34Qhoy321LoLERWfvCC4@mail.gmail.com>
References: <1299581872-18098-1-git-send-email-will.deacon@arm.com>
	<AANLkTi=uhEfpv1bD_Wtoq4i7kJ5D8yDFmqBwchAnqtXu@mail.gmail.com>
	<-4405681450588494999@unknownmsgid>
	<AANLkTin0xzSXRPbTqYkXp+2C34Qhoy321LoLERWfvCC4@mail.gmail.com>
Message-ID: <000801cbdf24$425fc360$c71f4a20$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

> Ah, yeah, I got it.
> 
> I think your patch is right, no need for me to repost. Please add my SOB
> 
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>

Thanks, submitted as 6798/1. Note that the patch system didn't like the
`re:' substring of ARM: aout-core: zero ... so the patch name has been
slightly mangled.

Will
