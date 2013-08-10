From: wharms@bfs.de (walter harms)
Date: Sat, 10 Aug 2013 19:49:46 +0200
Subject: [PATCH] arch/arm/mach-pxa/stargate2.c: use ARRAY_AND_SIZE
 consistently
In-Reply-To: <1376148738.2083.17.camel@joe-AO722>
References: <1376148353-9699-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376148738.2083.17.camel@joe-AO722>
Message-ID: <52067D3A.2090505@bfs.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 10.08.2013 17:32, schrieb Joe Perches:
> On Sat, 2013-08-10 at 17:25 +0200, Julia Lawall wrote:
>> From: Julia Lawall <Julia.Lawall@lip6.fr>
>>
>> Because ARRAY_AND_SIZE changes the apparent arity of a function, if it is
>> used for one call to a given function, it would be better, if possible, to
>> use it for all of them.
> 
> I think it'd be better to remove ARRAY_AND_SIZE instead.
> 

+1

:)

re,
 wh
