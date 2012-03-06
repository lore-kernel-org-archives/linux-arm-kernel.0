From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 6 Mar 2012 20:22:29 +0800
Subject: [PATCH] ARM: pxa: fix build failure for regulator consumer in
 em-x270.c
In-Reply-To: <20120306121627.GM19635@opensource.wolfsonmicro.com>
References: <1330989122-6323-1-git-send-email-paul.gortmaker@windriver.com>
 <4F55CEDB.90909@compulab.co.il>
 <CAN1soZxdT=N1BtK5Jf4+Qu3GGCHPuKK1BqgfEV-D7QorjnsLpg@mail.gmail.com>
 <20120306121627.GM19635@opensource.wolfsonmicro.com>
Message-ID: <CAN1soZyZwi5O089WedOzX-1h4SFKHF9kf=cBxM+3J08FA1RBvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 8:16 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Mar 06, 2012 at 05:12:18PM +0800, Haojian Zhuang wrote:
>
>> Could you pick up this patch since it's depend on latest change on regulator?
>
> There's no direct dependency, there's been no need to use that struct
> member for years - should be safe to just apply via the PXA tree. ?If
> you do want it to go via regulator please resend, I didn't keep a copy
> of the patch.

OK. Let me merge this patch.

Best Regards
Haojian
