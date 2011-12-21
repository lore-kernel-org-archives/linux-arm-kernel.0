From: davem@davemloft.net (David Miller)
Date: Wed, 21 Dec 2011 01:04:46 -0500 (EST)
Subject: [PATCH] net: macb: fix build break with !CONFIG_OF
In-Reply-To: <1324416029-28198-1-git-send-email-olof@lixom.net>
References: <1324416029-28198-1-git-send-email-olof@lixom.net>
Message-ID: <20111221.010446.2013036438835639474.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olof Johansson <olof@lixom.net>
Date: Tue, 20 Dec 2011 13:20:29 -0800

> This fixes the build of the macb driver that was broken by the DT changes:
> 
> drivers/net/ethernet/cadence/macb.c:1503: error: implicit declaration of function 'of_match_ptr'
> drivers/net/ethernet/cadence/macb.c:1503: error: 'macb_dt_ids' undeclared here (not in a function)
> drivers/net/ethernet/cadence/macb.c:1503: error: initializer element is not constant
> drivers/net/ethernet/cadence/macb.c:1503: error: (near initialization for 'macb_driver.driver.of_match_table')
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> Nicolas, care to ack this so I can apply it on top of the macb DT branch in arm-soc?

Yes, please apply it there.
