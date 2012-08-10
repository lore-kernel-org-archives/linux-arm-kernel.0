From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 10 Aug 2012 10:48:50 -0600
Subject: [PATCH] ARM: tegra: use IO_ADDRESS for getting virtual address
In-Reply-To: <1344603782-2541-1-git-send-email-ldewangan@nvidia.com>
References: <1344603782-2541-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <50253B72.5030209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2012 07:03 AM, Laxman Dewangan wrote:
> Use macro IO_ADDRESS for getting virtual address of
> corresponding physical address to make the consistency
> with rest of Tegra code-base.
> This macro calls the IO_TO_VIRT() which is defined in
> arch/arm/mach-tegra/include/mach/iomap.h

Thanks, applied to Tegra's for-3.7/fixes.
