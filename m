From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 2 Oct 2017 15:06:33 +0100
Subject: [PATCH] arm64: fix misleading data abort decoding
In-Reply-To: <1506944520-21998-1-git-send-email-mark.rutland@arm.com>
References: <1506944520-21998-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20171002140632.alqo4u5dn5uenjt7@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 12:42:00PM +0100, Mark Rutland wrote:
> Currently data_abort_decode() dumps the ISS field as a decimal value
> with a '0x' prefix, which is somewhat misleading.
> 
> Fix it to print as hexadecimal, as was intended.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Fixes: 1f9b8936f36f4a8e ("arm64: Decode information from ESR upon mem faults")
> ---
>  arch/arm64/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Queued for 4.14-rc4. Thanks.

-- 
Catalin
