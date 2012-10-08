From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 14:34:44 -0700
Subject: [PATCH] ARM: OMAP: hsmmc: fix return value check in
 omap_hsmmc_init_one()
In-Reply-To: <CAPgLHd9RvEA1_dtaHOTCnuoboU3jcwzn_trwucu9kDqqdR1Lcw@mail.gmail.com>
References: <CAPgLHd9RvEA1_dtaHOTCnuoboU3jcwzn_trwucu9kDqqdR1Lcw@mail.gmail.com>
Message-ID: <20121008213444.GQ13011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wei Yongjun <weiyj.lk@gmail.com> [120920 23:31]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function omap_device_alloc() returns ERR_PTR()
> not NULL pointer. The NULL test in the return value check should
> be replaced with IS_ERR().

Thanks applying into omap fixes.

Regards,

Tony
