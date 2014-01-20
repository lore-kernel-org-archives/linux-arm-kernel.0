From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Jan 2014 17:43:23 +0000
Subject: [PATCH v2 5/5] arm64: advertise ARMv8 extensions to 32-bit
 compat ELF binaries
In-Reply-To: <1387807592-26375-6-git-send-email-ard.biesheuvel@linaro.org>
References: <1387807592-26375-1-git-send-email-ard.biesheuvel@linaro.org>
 <1387807592-26375-6-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140120174322.GH29971@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 02:06:32PM +0000, Ard Biesheuvel wrote:
> This adds support for advertising the presence of ARMv8 Crypto
> Extensions in the Aarch32 execution state to 32-bit ELF binaries
> running in 32-bit compat mode under the arm64 kernel.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(for both arm64 patches in case they go in via a different route;
otherwise I'll take the arm64 patches if Russell is ok with merging the
arm ones)
