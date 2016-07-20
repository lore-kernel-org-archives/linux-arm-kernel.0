From: davem@davemloft.net (David Miller)
Date: Wed, 20 Jul 2016 14:47:51 -0700 (PDT)
Subject: [PATCH -next] net: axienet: Fix return value check in
 axienet_probe()
In-Reply-To: <1468927404-32270-1-git-send-email-weiyj_lk@163.com>
References: <1468927404-32270-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20160720.144751.2198896469609054053.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyj_lk@163.com>
Date: Tue, 19 Jul 2016 11:23:24 +0000

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function of_parse_phandle() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value
> check should be replaced with NULL test.
> 
> Fixes: 46aa27df8853 ('net: axienet: Use devm_* calls')
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied.
