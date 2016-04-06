From: julien.grall@arm.com (Julien Grall)
Date: Wed, 6 Apr 2016 12:43:04 +0100
Subject: [PATCH v10 04/17] arm/xen: Use xen_xlate_map_ballooned_pages to
 setup grant table
In-Reply-To: <1459525755-36968-5-git-send-email-shannon.zhao@linaro.org>
References: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
 <1459525755-36968-5-git-send-email-shannon.zhao@linaro.org>
Message-ID: <5704F648.8090603@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 01/04/2016 16:49, Shannon Zhao wrote:
> Use xen_xlate_map_ballooned_pages to setup grant table. Then it doesn't
> rely on DT or ACPI to pass the start address and size of grant table.
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Regards,

-- 
Julien Grall
