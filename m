From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 12 Oct 2012 18:20:15 +0530
Subject: [PATCH] davinci: fix return value check by using IS_ERR in
 tnetv107x_devices_init()
In-Reply-To: <CAPgLHd-xYzLwnptYpOV4HrdJyn3AZahx2VGVAVLHiEYvcj-APw@mail.gmail.com>
References: <CAPgLHd-xYzLwnptYpOV4HrdJyn3AZahx2VGVAVLHiEYvcj-APw@mail.gmail.com>
Message-ID: <50781207.8060701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On 9/21/2012 11:42 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function clk_get() returns ERR_PTR() not
> NULL pointer. The NULL test in the error handling should be
> replaced with IS_ERR().
> 
> dpatch engine is used to auto generated this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Queuing this for v3.8. While committing, I added ARM: prefix to the
subject line as is the norm with all arch/arm/* patches.

Thanks,
Sekhar
