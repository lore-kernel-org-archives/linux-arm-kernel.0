From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Thu, 29 Jan 2015 08:33:23 -0800
Subject: [PATCH] soc: ti: knav_qmss_queue: export API calls for use by
 user driver
In-Reply-To: <1422486021-23874-1-git-send-email-m-karicheri2@ti.com>
References: <1422486021-23874-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <54CA60D3.6090008@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/28/2015 3:00 PM, Murali Karicheri wrote:
> Currently only few of the API calls are exported. This creates problem
> when the knav* modules are built as modules and another user module
> such as netcp_core try to use these API calls and they are also built
> as module. This patch export these APIs to address the issue.
>
> This is needed to support allmodconfig for ARM
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
Looks fine. I will pick this up for next merge window.

Regards,
Santosh
