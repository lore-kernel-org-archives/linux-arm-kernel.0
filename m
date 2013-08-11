From: wharms@bfs.de (walter harms)
Date: Sun, 11 Aug 2013 09:34:40 +0200
Subject: [PATCH] arch/arm/mach-pxa/stargate2.c: use ARRAY_AND_SIZE
 consistently
In-Reply-To: <alpine.DEB.2.02.1308110745030.2072@localhost6.localdomain6>
References: <1376148353-9699-1-git-send-email-Julia.Lawall@lip6.fr>
 <20130810223338.GM5502@mwanda>
 <alpine.DEB.2.02.1308110745030.2072@localhost6.localdomain6>
Message-ID: <52073E90.2030008@bfs.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 11.08.2013 07:48, schrieb Julia Lawall:
> On Sun, 11 Aug 2013, Dan Carpenter wrote:
> 
>> ARRAY_AND_SIZE() macro is horrible, and I would like it if it were
>> removed.  What I meant before was just that probably people will
>> probably complain if we try to remove it.
> 
> Well, I could either wait for someone to defend it, or send a patch 
> getting rid of it and see what happens...  I can't see what could go wrong 
> with
> 
> f(...,
> - ARRAY_AND_SIZE(e)
> + e, ARRAY_SIZE(e)
>   , ...)
> 
> so it should be an easy patch to create.
> 


if it is not to much work, send a patch to get rid of it.
It seems all agree that the disadvantages outweighs it
advantages.

just my 2 cents,
 wh
