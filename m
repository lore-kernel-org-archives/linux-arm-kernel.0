From: julien.grall@arm.com (Julien Grall)
Date: Wed, 6 Apr 2016 13:26:58 +0100
Subject: [PATCH v10 07/17] Xen: ARM: Add support for mapping AMBA device
 mmio
In-Reply-To: <1459525755-36968-8-git-send-email-shannon.zhao@linaro.org>
References: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
 <1459525755-36968-8-git-send-email-shannon.zhao@linaro.org>
Message-ID: <57050092.4060707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 01/04/2016 16:49, Shannon Zhao wrote:
> Add a bus_notifier for AMBA bus device in order to map the device
> mmio regions when DOM0 booting with ACPI.
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Regards,

-- 
Julien Grall
