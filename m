From: davem@davemloft.net (David Miller)
Date: Mon, 15 Aug 2016 16:34:43 -0700 (PDT)
Subject: [PATCH -next] net: phy: Fix return value check in
 xgmiitorgmii_probe()
In-Reply-To: <1471300497-15066-1-git-send-email-weiyj.lk@gmail.com>
References: <1471300497-15066-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160815.163443.1332884548426044511.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Mon, 15 Aug 2016 22:34:57 +0000

> In case of error, the function of_parse_phandle() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Applied.
