From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Jan 2014 17:40:08 +0000
Subject: [PATCH v2 2/5] binfmt_elf: add ELF_HWCAP2 to compat auxv entries
In-Reply-To: <1387807592-26375-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1387807592-26375-1-git-send-email-ard.biesheuvel@linaro.org>
 <1387807592-26375-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140120174008.GF29971@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 02:06:29PM +0000, Ard Biesheuvel wrote:
> Add ELF_HWCAP2 to the set of auxv entries that is passed to
> a 32-bit ELF program running in 32-bit compat mode under a
> 64-bit kernel.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
