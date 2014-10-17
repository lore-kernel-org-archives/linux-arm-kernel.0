From: mpe@ellerman.id.au (Michael Ellerman)
Date: Fri, 17 Oct 2014 18:23:20 +1100
Subject: [PATCH v3 21/27] Powerpc/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
In-Reply-To: <1413342435-7876-22-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
 <1413342435-7876-22-git-send-email-wangyijing@huawei.com>
Message-ID: <1413530600.21650.5.camel@concordia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-10-15 at 11:07 +0800, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
> Hi Michael,
>    I dropped the Acked-by , because this version has a
> lot changes compared to last. So, I guess you may want to check it again.

OK thanks.

Still looks OK and boots on one of my test systems that uses MSI.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (for powerpc)


cheers
