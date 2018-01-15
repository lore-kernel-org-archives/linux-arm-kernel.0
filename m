From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Jan 2018 18:21:11 +0000
Subject: [PATCH 0/3] Fixes for 52-bit physical address patches
In-Reply-To: <1516029830-12326-1-git-send-email-kristina.martsenko@arm.com>
References: <1516029830-12326-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <20180115182111.g6ruvfjoyswwppcq@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 03:23:47PM +0000, Kristina Martsenko wrote:
> Kristina Martsenko (3):
>   arm64: fix ID map extension to 52 bits
>   KVM: arm/arm64: fix HYP ID map extension to 52 bits
>   arm64: fix comment above tcr_compute_pa_size

Thanks Kristina. Applied.

-- 
Catalin
