From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 02 Oct 2012 14:36:52 -0700
Subject: [PATCH] ARM: OMAP: omap_device: fix return value check in
 omap_device_build_ss()
In-Reply-To: <CAPgLHd8ys7uU8wBhMF7JWZEDAddOnGo4vHPu1V_+Q3__WWK-3g@mail.gmail.com>
 (Wei Yongjun's message of "Fri, 21 Sep 2012 14:32:04 +0800")
References: <CAPgLHd8ys7uU8wBhMF7JWZEDAddOnGo4vHPu1V_+Q3__WWK-3g@mail.gmail.com>
Message-ID: <87lifo8sjv.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wei Yongjun <weiyj.lk@gmail.com> writes:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function omap_device_alloc() returns ERR_PTR()
> and never returns NULL pointer. The NULL test in the return value
> check should be replaced with IS_ERR().
>
> dpatch engine is used to auto generated this patch.
> (https://github.com/weiyj/dpatch)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks, queueing this for v3.7-rc.

Kevin
