From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Jan 2014 17:39:41 +0000
Subject: [PATCH v2 1/5] ARM: add support for AT_HWCAP2 ELF auxv entry
In-Reply-To: <1387807592-26375-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1387807592-26375-1-git-send-email-ard.biesheuvel@linaro.org>
 <1387807592-26375-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140120173941.GE29971@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 02:06:28PM +0000, Ard Biesheuvel wrote:
> This enables AT_HWCAP2 for ARM. The generic support for this
> new ELF auxv entry was added in commit 2171364d1a9 (powerpc:
> Add HWCAP2 aux entry)
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
