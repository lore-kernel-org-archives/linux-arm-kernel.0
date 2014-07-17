From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Jul 2014 13:04:41 +0100
Subject: [PATCH v3 3/3] arm64: Use include/asm-generic/io.h
In-Reply-To: <1405508484-18303-3-git-send-email-thierry.reding@gmail.com>
References: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
 <1405508484-18303-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140717120441.GI18203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 12:01:24PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Include the generic I/O header file so that duplicate implementations
> can be removed. This will also help to establish consistency across more
> architectures regarding which accessors they support.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v3:
> - add io{read,write}{16,32}be() to match what 32-bit ARM does

It looks fine. Thanks.

-- 
Catalin
