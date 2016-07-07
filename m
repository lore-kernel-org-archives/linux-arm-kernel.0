From: davem@davemloft.net (David Miller)
Date: Wed, 06 Jul 2016 22:31:52 -0700 (PDT)
Subject: [PATCH -next] net: mediatek: remove .owner field for driver
In-Reply-To: <1467811813-4864-1-git-send-email-weiyj_lk@163.com>
References: <1467811813-4864-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20160706.223152.980979934196013750.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: weiyj_lk@163.com
Date: Wed,  6 Jul 2016 13:30:13 +0000

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove .owner field since calls to module_platform_driver() will
> set it automatically.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied.
