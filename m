From: davem@davemloft.net (David Miller)
Date: Sat, 03 Nov 2012 15:38:52 -0400 (EDT)
Subject: [PATCH net-next 0/2] cpsw: fix resource leak for v3.8
In-Reply-To: <cover.1351930782.git.richardcochran@gmail.com>
References: <cover.1351930782.git.richardcochran@gmail.com>
Message-ID: <20121103.153852.2120943445145443586.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Cochran <richardcochran@gmail.com>
Date: Sat,  3 Nov 2012 09:25:28 +0100

> While looking at the idea of removing all of the register offsets in
> the CPSW's device tree, I noticed that the driver would be leaking IO
> mappings. Although this is, strictly speaking, a bug fix, still it can
> wait to appear in v3.8, since there is no way to use the driver in
> v3.7 (or earlier) anyhow.

All applied, thanks.
