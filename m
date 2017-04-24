From: kubakici@wp.pl (Jakub Kicinski)
Date: Sun, 23 Apr 2017 20:49:43 -0700
Subject: [PATCH 1/1] mt7601u: check return value of alloc_skb
In-Reply-To: <1492930823-17249-1-git-send-email-bianpan2016@163.com>
References: <1492930823-17249-1-git-send-email-bianpan2016@163.com>
Message-ID: <20170423204943.3ce98a63@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 23 Apr 2017 15:00:23 +0800, Pan Bian wrote:
> Function alloc_skb() will return a NULL pointer if there is no enough
> memory. However, in function mt7601u_mcu_msg_alloc(), its return value
> is not validated before it is used. This patch fixes it.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Acked-by: Jakub Kicinski <kubakici@wp.pl>

Thanks!
