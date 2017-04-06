From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Apr 2017 18:12:00 +0100
Subject: [PATCH V14 00/10] Add UEFI 2.6 and ACPI 6.1 updates for RAS on
 ARM64
In-Reply-To: <1490729440-32591-1-git-send-email-tbaicar@codeaurora.org>
References: <1490729440-32591-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20170406171200.GE7705@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Tue, Mar 28, 2017 at 01:30:30PM -0600, Tyler Baicar wrote:
> Tyler Baicar (9):
>   acpi: apei: read ack upon ghes record consumption
>   ras: acpi/apei: cper: generic error data entry v3 per ACPI 6.1
>   efi: parse ARM processor error
>   arm64: exception: handle Synchronous External Abort
>   acpi: apei: handle SEA notification type for ARMv8
>   efi: print unrecognized CPER section
>   ras: acpi / apei: generate trace event for unrecognized CPER section
>   trace, ras: add ARM processor error trace event
>   arm/arm64: KVM: add guest SEA support

It looks like the KVM parts are getting acked and the arm64 and efi bits
have been acked as well. Are you ok to take this series through the ACPI
tree?

Thanks.

-- 
Catalin
