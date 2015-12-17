From: davem@davemloft.net (David Miller)
Date: Wed, 16 Dec 2015 19:16:47 -0500 (EST)
Subject: [PATCH] net: add Qualcomm IPC router
In-Reply-To: <20151217000141.GG28026@sonymobile.com>
References: <1449866519-14551-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20151215.160114.1178824607335349574.davem@davemloft.net>
 <20151217000141.GG28026@sonymobile.com>
Message-ID: <20151216.191647.857597925395214968.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Courtney Cavin <courtney.cavin@sonymobile.com>
Date: Wed, 16 Dec 2015 16:01:41 -0800

> We could hardcode the value in kconfig, but that seems like a worse
> solution than a module parameter.
> 
> I'm open to further suggestions.

No module parameters, configure it via netlink or similar at run
time.
