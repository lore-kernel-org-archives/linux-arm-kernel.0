From: davem@davemloft.net (David Miller)
Date: Mon, 11 Jun 2012 02:03:52 -0700 (PDT)
Subject: [PATCH 1/3] net: lpc_eth: Replace WARN() trace with simple
 pr_warn()
In-Reply-To: <4FD5AE1D.9030807@antcom.de>
References: <1339401793-12258-1-git-send-email-stigge@antcom.de>
 <1339403108.6001.1697.camel@edumazet-glaptop>
 <4FD5AE1D.9030807@antcom.de>
Message-ID: <20120611.020352.1962768244524496467.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roland Stigge <stigge@antcom.de>
Date: Mon, 11 Jun 2012 10:36:45 +0200

> But maybe this is wrong. Can you please give me a hint how the net
> subsystem makes sure that this doesn't happen under normal circumstances?

Well if you are asking this question then you didn't read my feedback,
because I explained exactly what prevents this.
