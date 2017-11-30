From: davem@davemloft.net (David Miller)
Date: Thu, 30 Nov 2017 09:24:33 -0500 (EST)
Subject: [PATCH net-next] net: thunderx: Set max queue count taking
 XDP_TX into account
In-Reply-To: <20171124120411.7660-1-aleksey.makarov@cavium.com>
References: <20171124120411.7660-1-aleksey.makarov@cavium.com>
Message-ID: <20171130.092433.619680055146845186.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Aleksey Makarov <aleksey.makarov@cavium.com>
Date: Fri, 24 Nov 2017 15:04:03 +0300

> From: Sunil Goutham <sgoutham@cavium.com>
> 
> on T81 there are only 4 cores, hence setting max queue count to 4
> would leave nothing for XDP_TX. This patch fixes this by doubling
> max queue count in above scenarios.
> 
> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
> Signed-off-by: cjacob <cjacob@caviumnetworks.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>

Applied.
