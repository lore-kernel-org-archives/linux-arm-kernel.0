From: davem@davemloft.net (David Miller)
Date: Thu, 03 Aug 2017 15:16:31 -0700 (PDT)
Subject: [PATCH net-next v2 0/7] net: mvpp2: add TX interrupts support
In-Reply-To: <20170803084201.30305-1-thomas.petazzoni@free-electrons.com>
References: <20170803084201.30305-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20170803.151631.1327349080053900395.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Thu,  3 Aug 2017 10:41:54 +0200

> So far, the mvpp2 driver was using an hrtimer to handle TX
> completion. This patch series adds support for using TX interrupts
> (for each CPU) on PPv2.2, the variant of the IP used on Marvell Armada
> 7K/8K.
> 
> Dave: this version can be applied right away, it no longer depends on
> Antoine's patch series. Antoine series had some comments, so he will
> have to respin later on. Therefore, let's merge this smaller patch
> series first.
> 
> Changes since v1:
> 
>  - Rebased on top of net-next, instead of on top of Antoine's series.
> 
>  - Removed the Device Tree patch, as it shouldn't go through the net
>    tree.

Series applied.
