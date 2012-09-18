From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 18 Sep 2012 12:31:45 +0200
Subject: [PATCH 09/24] ARM: ixp4xx: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-10-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Fri, 14 Sep 2012 23:34:37 +0200")
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-10-git-send-email-arnd@arndb.de>
Message-ID: <m3ipbbmxke.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> ARM is moving to stricter checks on readl/write functions,
> so we need to use the correct types everywhere.
>
> At the moment, this patch conflicts with other patches in linux-next,
> need to sort this out.

Very nice, I will take care of these 3 patches.
-- 
Krzysztof Halasa
