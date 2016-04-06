From: julien.grall@arm.com (Julien Grall)
Date: Wed, 6 Apr 2016 13:35:17 +0100
Subject: [PATCH v10 11/17] ARM: XEN: Move xen_early_init() before
 efi_init()
In-Reply-To: <1459525755-36968-12-git-send-email-shannon.zhao@linaro.org>
References: <1459525755-36968-1-git-send-email-shannon.zhao@linaro.org>
 <1459525755-36968-12-git-send-email-shannon.zhao@linaro.org>
Message-ID: <57050285.90701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 01/04/2016 16:49, Shannon Zhao wrote:
> Move xen_early_init() before efi_init(), then when calling efi_init()
> could initialize Xen specific UEFI.
>
> Check if it runs on Xen hypervisor through the flat dts.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Regards,

-- 
Julien Grall
