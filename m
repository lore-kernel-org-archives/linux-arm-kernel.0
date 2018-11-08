From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Nov 2018 17:51:00 +0000
Subject: [PATCH] arm64: mm: define NET_IP_ALIGN to 0
In-Reply-To: <20181107171038.25281-1-ard.biesheuvel@linaro.org>
References: <20181107171038.25281-1-ard.biesheuvel@linaro.org>
Message-ID: <20181108175059.GE144107@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 06:10:38PM +0100, Ard Biesheuvel wrote:
> On arm64, there is no need to add 2 bytes of padding to the start of
> each network buffer just to make the IP header appear 32-bit aligned.
> 
> Since this might actually adversely affect DMA performance some
> platforms, let's override NET_IP_ALIGN to 0 to get rid of this
> padding.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Queued for 4.20. Thanks

-- 
Catalin
