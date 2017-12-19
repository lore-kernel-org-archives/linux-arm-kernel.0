From: davem@davemloft.net (David Miller)
Date: Tue, 19 Dec 2017 13:48:10 -0500 (EST)
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <1513588684-15647-1-git-send-email-mw@semihalf.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
Message-ID: <20171219.134810.48027351795338458.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>
Date: Mon, 18 Dec 2017 10:17:56 +0100

> Above support configures 1G to use its PHY normally. 10G can work now
> only with the link interrupt mode. Somehow reading of the
> string property in fwnode_mdiobus_child_is_phy works only with
> DT and cannot cope with 10G PHY nodes as in:
> https://pastebin.com/3JnYpU0A
> 
> Above root cause will be further checked. In the meantime I will
> appreciate any comments or remarks for the kernel patches.

I would like you to figure this out before these changes go in.

Thanks.
