From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Thu, 29 Jan 2015 13:25:26 -0800
Subject: [PATCH 1/2] soc: ti: knav_qmss_queue: makefile tweak to build
 as dynamic module
In-Reply-To: <1422563870-19252-1-git-send-email-m-karicheri2@ti.com>
References: <1422563870-19252-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <54CAA546.6060501@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/29/15 12:37 PM, Murali Karicheri wrote:
> Currently configuring qmss and dma as dynamic module creates three .ko
> files. knav_qmss_acc.ko and knav_qmss_queue.ko both can't be insmod
> because of circular dependency. So combine these two into one module
> by changing the makefile.
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

Applied both $subject and 2/2. Thanks

Regards,
Santosh
