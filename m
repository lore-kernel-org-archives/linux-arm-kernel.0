From: olekstysh@gmail.com (Oleksandr Tyshchenko)
Date: Mon, 13 Feb 2017 13:50:29 +0200
Subject: [RFC PATCH v1] iommu/io-pgtable-arm: Check for leaf entry right
 after finding it
In-Reply-To: <20170213112728.GH1512@arm.com>
References: <1486648600-27457-1-git-send-email-olekstysh@gmail.com>
 <CAPD2p-=TtT9ZHpLu8w9jUdKR5u6JG_BGtz0BDDKejmWS-jQ9WQ@mail.gmail.com>
 <20170213112728.GH1512@arm.com>
Message-ID: <CAPD2p-=pVgJvVY7GFPWWqj9wp96JSsxD-SO5oNXxq9ag2wWT0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 1:27 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Feb 13, 2017 at 01:07:02PM +0200, Oleksandr Tyshchenko wrote:
>> Any comments?
>
> Looks fine to me, but I don't think it's urgent and I already sent my
> SMMU pull for 4.11. I'll send this as a fix after the merge window.
OK. Thank you.

>
> I suspect we need something similar for io-pgtable-arm-v7s.c, too.
Agree. On the whole I will be able to make similar patch for arm-v7s,
but I won't be 100% sure
since I don't have any boards where arm-v7s compatible IOMMU installed.

Shall I make patch for arm-v7s too?

>
> Will



-- 
Regards,

Oleksandr Tyshchenko
