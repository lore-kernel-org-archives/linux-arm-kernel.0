From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 11:51:53 +0100
Subject: [PATCH v11 12/17] ARM64: ACPI: Check if it runs on Xen to enable
 or disable ACPI
In-Reply-To: <1460030614-16112-13-git-send-email-zhaoshenglong@huawei.com>
References: <1460030614-16112-1-git-send-email-zhaoshenglong@huawei.com>
 <1460030614-16112-13-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160422105152.GF2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 08:03:29PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> When it's a Xen domain0 booting with ACPI, it will supply a /chosen and
> a /hypervisor node in DT. So check if it needs to enable ACPI.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
