From: davem@davemloft.net (David Miller)
Date: Thu, 21 Apr 2016 15:31:44 -0400 (EDT)
Subject: [PATCH v2 0/4] net: thunderx: Add multiqset support for DPDK
In-Reply-To: <1461221872-38841-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1461221872-38841-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20160421.153144.774884339123710587.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sunil.kovvuri@gmail.com
Date: Thu, 21 Apr 2016 12:27:48 +0530

> This patch series mainly adds support for userspace application
> like DPDK with a VNIC VF attached to request additional QSets
> for having morethan the default 8 queues.

I don't think it's appropriate to add facilities for non-upstream
features, especially DPDK.

Thanks.
