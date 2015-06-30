From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 30 Jun 2015 18:04:01 +0100
Subject: [PATCH 1/2] arm64: fix incorrect use of pgprot_t variable
In-Reply-To: <1435680290-13945-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1435680290-13945-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150630170401.GM7445@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 06:04:49PM +0200, Ard Biesheuvel wrote:
> This fixes a build failure under STRICT_MM_TYPECHECKS, by adding
> a missing pgprot_val() around a pgport_t reference.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied. Thanks.

-- 
Catalin
