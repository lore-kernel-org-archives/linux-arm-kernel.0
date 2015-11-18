From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 18 Nov 2015 12:09:29 +0000
Subject: [Xen-devel] [PATCH v3 51/62] arm/acpi: Prepare EFI system table
 for Dom0
In-Reply-To: <1447753261-7552-52-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-52-git-send-email-shannon.zhao@linaro.org>
Message-ID: <564C6A79.10709@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/domain_build.c |  2 ++
>  xen/common/efi/boot.c       | 64 +++++++++++++++++++++++++++++++++++++++++++++

Why do you add the creation of ACPI table in efi/boot.c?

This file is only supposed to contain the EFI stub and nothing else.

Regards,

-- 
Julien Grall
