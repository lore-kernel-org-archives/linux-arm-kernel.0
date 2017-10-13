From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 13 Oct 2017 15:19:44 +0800
Subject: [PATCH v2 2/3] ACPI/IORT: Improve functions return type/storage
 class specifier indentation
In-Reply-To: <1507824047-17045-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1507824047-17045-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1507824047-17045-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <59E06910.40404@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/10/13 0:00, Lorenzo Pieralisi wrote:
> Some functions definition indentations are using a style that is frowned
> upon with return value type/storage class specifier in a separate line.
>
> Reindent the function definitions to fix them.

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

By the way, I tested this patch set on D05 with no regressions.

Thanks
Hanjun
