From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Jan 2014 15:01:23 +0000
Subject: [PATCH v2 resend 0/5] arm64: advertise availability of CRC and
 crypto instructions
In-Reply-To: <1389950591-4212-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1389950591-4212-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140123150123.GH27520@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 09:23:06AM +0000, Ard Biesheuvel wrote:
> Ard Biesheuvel (5):
>   ARM: add support for AT_HWCAP2 ELF auxv entry
>   binfmt_elf: add ELF_HWCAP2 to compat auxv entries
>   arm64: add AT_HWCAP2 support for 32-bit compat
>   ARM: introduce HWCAP2 feature bits for ARMv8 Crypto Extensions
>   arm64: advertise ARMv8 extensions to 32-bit compat ELF binaries

I think I acked this series but probably after you posted the resend.
Just in case I haven't:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
