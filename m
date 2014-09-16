From: mpe@ellerman.id.au (Michael Ellerman)
Date: Tue, 16 Sep 2014 15:28:37 +1000
Subject: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
In-Reply-To: <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
Message-ID: <1410845317.12488.2.camel@concordia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-09-05 at 18:10 +0800, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

This looks fine and seems to boot OK.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
