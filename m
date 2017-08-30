From: davem@davemloft.net (David Miller)
Date: Wed, 30 Aug 2017 15:20:35 -0700 (PDT)
Subject: [PATCH] net: bcm63xx_enet: make bcm_enetsw_ethtool_ops const
In-Reply-To: <1504085108-23495-1-git-send-email-bhumirks@gmail.com>
References: <1504085108-23495-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170830.152035.99832287168105841.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 30 Aug 2017 14:55:08 +0530

> Make this const as it is never modified.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to net-next.
