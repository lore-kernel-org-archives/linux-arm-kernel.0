From: laforge@gnumonks.org (Harald Welte)
Date: Fri, 6 Nov 2009 11:32:23 +0900
Subject: [PATCH 01/17] ARM: MM: use 64bytes of L1 cache on plat S5PC1xx
In-Reply-To: <1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091106023222.GF3913@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

> Samsung S5PC1xx SoCs are Coretex8 based, so use 64 bytes of L1 cache
> line instead of the default 32 bytes.

this is an obvious fix, and I'd recommend Ben should merge it asap (if he
didn't already)
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
