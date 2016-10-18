From: davem@davemloft.net (David Miller)
Date: Tue, 18 Oct 2016 10:42:53 -0400 (EDT)
Subject: [PATCH v4 0/4] add support for impedance control for TI
 dp83867 phy and fix 2nd ethernet on dra72 rev C evm
In-Reply-To: <20161018112020.30273-1-mugunthanvnm@ti.com>
References: <20161018112020.30273-1-mugunthanvnm@ti.com>
Message-ID: <20161018.104253.1412536252154725850.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Tue, 18 Oct 2016 16:50:16 +0530

> Add support for configurable impedance control for TI dp83867
> phy via devicetree. More documentation in [1].
> CPSW second ethernet is not working, fix it by enabling
> impedance configuration on the phy.

Series applied to net-next, thanks.
