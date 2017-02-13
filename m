From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Feb 2017 11:27:28 +0000
Subject: [RFC PATCH v1] iommu/io-pgtable-arm: Check for leaf entry right
 after finding it
In-Reply-To: <CAPD2p-=TtT9ZHpLu8w9jUdKR5u6JG_BGtz0BDDKejmWS-jQ9WQ@mail.gmail.com>
References: <1486648600-27457-1-git-send-email-olekstysh@gmail.com>
 <CAPD2p-=TtT9ZHpLu8w9jUdKR5u6JG_BGtz0BDDKejmWS-jQ9WQ@mail.gmail.com>
Message-ID: <20170213112728.GH1512@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 01:07:02PM +0200, Oleksandr Tyshchenko wrote:
> Any comments?

Looks fine to me, but I don't think it's urgent and I already sent my
SMMU pull for 4.11. I'll send this as a fix after the merge window.

I suspect we need something similar for io-pgtable-arm-v7s.c, too.

Will
