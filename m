From: julien.grall@arm.com (Julien Grall)
Date: Wed, 6 Apr 2016 13:31:11 +0100
Subject: [PATCH v10 10/17] arm/xen: Get event-channel irq through
 HVM_PARAM when booting with ACPI
In-Reply-To: <1459525755-36968-11-git-send-email-shannon.zhao@linaro.org>
References: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
 <1459525755-36968-11-git-send-email-shannon.zhao@linaro.org>
Message-ID: <5705018F.9060702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 01/04/2016 16:49, Shannon Zhao wrote:
> The kernel will get the event-channel IRQ through
> HVM_PARAM_CALLBACK_IRQ.
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Regards,

-- 
Julien Grall
