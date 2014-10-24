From: davem@davemloft.net (David Miller)
Date: Fri, 24 Oct 2014 15:50:31 -0400 (EDT)
Subject: [PATCH v2 0/9] Marvell PXA168 libphy handling and Berlin Ethernet
In-Reply-To: <1414002412-13615-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1414002412-13615-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20141024.155031.1468501419050363586.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Wed, 22 Oct 2014 20:26:43 +0200

> This patch series deals with a removing a IP feature that can be found
> on all currently supported Marvell Ethernet IP (pxa168_eth, mv643xx_eth,
> mvneta). The MAC IP allows to automatically perform PHY auto-negotiation
> without software interaction.
> 
> However, this feature (a) fundamentally clashes with the way libphy works
> and (b) is unable to deal with quirky PHYs that require special treatment.
> In this series, pxa168_eth driver is rewritten to completely disable that
> feature and properly deal with libphy provided PHYs.
> 
> As usual, a branch on top of v3.18-rc1 can be found at
> 
> git://git.infradead.org/users/hesselba/linux-berlin.git devel/bg2-bg2cd-eth-v2
> 
> Patches 1-5 should go through David's net tree, I'll pick up the DT patches
> 6-9.

Patches 1-5 applied to net-next, thanks.
