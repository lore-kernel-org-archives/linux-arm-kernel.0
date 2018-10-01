From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Oct 2018 11:58:37 +0100
Subject: [PATCH] arm64: remove unused asm/compiler.h header file
In-Reply-To: <20180927130737.31301-1-ard.biesheuvel@linaro.org>
References: <20180927130737.31301-1-ard.biesheuvel@linaro.org>
Message-ID: <20181001105836.GD131162@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 03:07:37PM +0200, Ard Biesheuvel wrote:
> arm64 does not define CONFIG_HAVE_ARCH_COMPILER_H, nor does it keep
> anything useful in its copy of asm/compiler.h, so let's remove it
> before anybody starts using it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Queued for 4.20. Thanks.

-- 
Catalin
