From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sat, 6 Feb 2016 11:23:07 +0100
Subject: [PATCH v4 01/17] Xen: ACPI: Hide UART used by Xen
In-Reply-To: <1454641552-12576-2-git-send-email-zhaoshenglong@huawei.com>
References: <1454641552-12576-1-git-send-email-zhaoshenglong@huawei.com>
 <1454641552-12576-2-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <CAJZ5v0id-035AtyQ_SccPuCxD7+pa6GCgj3WBAojM+rFqssGQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 5, 2016 at 4:05 AM, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
>
> ACPI 6.0 introduces a new table STAO to list the devices which are used
> by Xen and can't be used by Dom0. On Xen virtual platforms, the physical
> UART is used by Xen. So here it hides UART from Dom0.
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Well, this doesn't look right to me.

We need to find a nicer way to achieve what you want.

Thanks,
Rafael
