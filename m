From: davem@davemloft.net (David Miller)
Date: Wed, 12 Oct 2016 01:54:22 -0400 (EDT)
Subject: [PATCH net-next 0/2] drivers: net: xgene: fix: Use GPIO to get
 link status
In-Reply-To: <1475789758-5196-1-git-send-email-isubramanian@apm.com>
References: <1475789758-5196-1-git-send-email-isubramanian@apm.com>
Message-ID: <20161012.015422.1466108933958598182.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Thu,  6 Oct 2016 14:35:56 -0700

> Since the link value reported by the link status register is not
> reliable if no SPF module inserted, this patchset fixes the issue by
> using GPIO to determine the link status when no module inserted.
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Signed-off-by: Quan Nguyen <qnguyen@apm.com>

Series applied, thanks.
