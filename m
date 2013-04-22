From: mpatocka@redhat.com (Mikulas Patocka)
Date: Mon, 22 Apr 2013 13:32:53 -0400 (EDT)
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <5170B4C6.1030300@gmail.com>
References: <5170B4C6.1030300@gmail.com>
Message-ID: <Pine.LNX.4.64.1304221318350.22065@file.rdu.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thu, 18 Apr 2013, Rob Herring wrote:

> Current errors in linux-next for ARM multi-platform randconfig builds.
> 
> Rob
> 
> drivers/built-in.o:drivers/md/dm-cache-target.c:429: more undefined references to `__udivdi3' follow
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/md/dm-cache-target.c:429: undefined reference to `__udivdi3'
> /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/md/dm-cache-target.c:429: undefined reference to `__umoddi3'
> driversdrivers/md/dm-cache-target.c:429: more undefined references to `__udivdi3' follow
> drivers/md/dm-cache-target.c:429: undefined reference to `__udivdi3'
> drivers/md/dm-cache-target.c:429: undefined reference to `__umoddi3'

Hi

I tried to cross-compile dm-cache on linux-next for arm and there were no 
failures and no references to __udivdi3 and __umoddi3.

Please send the .config file that resulted in these faulures.

Mikulas
