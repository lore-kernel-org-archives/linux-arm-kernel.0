From: davem@davemloft.net (David Miller)
Date: Mon, 22 Aug 2016 18:08:44 -0700 (PDT)
Subject: [PATCH -next v2] net: phy: Add missing of_node_put() in
 xgmiitorgmii_probe()
In-Reply-To: <1471819575-13389-1-git-send-email-weiyj.lk@gmail.com>
References: <1471706815-27723-1-git-send-email-weiyj.lk@gmail.com>
 <1471819575-13389-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160822.180844.554192467754944953.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Sun, 21 Aug 2016 22:46:15 +0000

> This node pointer is returned by of_parse_phandle() with
> refcount incremented in this function. of_node_put() on it
> before exitting this function.
> 
> This is detected by Coccinelle semantic patch.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Applied.
