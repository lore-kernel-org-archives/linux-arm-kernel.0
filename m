From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Mar 2015 18:08:56 +0000
Subject: [PATCH v2 2/3] arm64: remove __switch_data object from head.S
In-Reply-To: <1425468197-22377-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1425468197-22377-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425468197-22377-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150304180856.GD28951@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 12:23:16PM +0100, Ard Biesheuvel wrote:
> This removes the confusing __switch_data object from head.S,
> and replaces it with standard PC-relative references to the
> various symbols it encapsulates.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
