From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 30 Jun 2014 17:24:06 +0100
Subject: [PATCH v4 05/13] ARM64 / ACPI: Introduce arm-core.c and its
 related head file
In-Reply-To: <1403840976-7456-6-git-send-email-hanjun.guo@linaro.org>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
 <1403840976-7456-6-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140630162406.GR28951@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 04:49:28AM +0100, Hanjun Guo wrote:
>  drivers/acpi/Makefile          |    2 +
>  drivers/acpi/plat/Makefile     |    1 +
>  drivers/acpi/plat/arm-core.c   |  110 ++++++++++++++++++++++++++++++++++++++++

Do you ever plan to add ACPI support for 32-bit ARM? If not, this part
could be placed under arch/arm64 (similar to x86).

-- 
Catalin
