From: davem@davemloft.net (David Miller)
Date: Mon, 26 Nov 2012 17:23:43 -0500 (EST)
Subject: [PATCH net-next] cpts: add missing kconfig dependency
In-Reply-To: <1353931638-1023-1-git-send-email-richardcochran@gmail.com>
References: <1353931638-1023-1-git-send-email-richardcochran@gmail.com>
Message-ID: <20121126.172343.219794518162131020.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 26 Nov 2012 13:07:18 +0100

> The Common Platform Time Sync function of the CPSW does not depend the
> CPSW configuration option as it should. This patch fixes the issue by
> adding the dependency.
> 
> Signed-off-by: Richard Cochran <richardcochran@gmail.com>

Applied.
