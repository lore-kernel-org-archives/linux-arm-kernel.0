From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Mar 2015 18:08:41 +0000
Subject: [PATCH v2 1/3] arm64: remove processor_id
In-Reply-To: <1425468197-22377-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1425468197-22377-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425468197-22377-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150304180841.GC28951@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 12:23:15PM +0100, Ard Biesheuvel wrote:
> The global processor_id is assigned the MIDR_EL1 value of the boot
> CPU in the early init code, but is never referenced afterwards.
> 
> So remove it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
