From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 14:32:12 -0700
Subject: [PATCH] OMAPDSS: fix return value check in create_dss_pdev()
In-Reply-To: <CAPgLHd-G9Otuu2KT3e8WuW+yxLrHH68vj3dEgOXOZFo70=YFnQ@mail.gmail.com>
References: <CAPgLHd-G9Otuu2KT3e8WuW+yxLrHH68vj3dEgOXOZFo70=YFnQ@mail.gmail.com>
Message-ID: <20121008213212.GP13011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wei Yongjun <weiyj.lk@gmail.com> [120920 23:29]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function omap_device_alloc() returns ERR_PTR()
> not NULL pointer. The NULL test in the return value check should
> be replaced with IS_ERR().

Thanks applying into omap fixes.

Regards,

Tony
