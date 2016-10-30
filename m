From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 30 Oct 2016 14:47:01 +0000
Subject: [PATCH v4 0/3] arm64/mm: use the contiguous attribute for kernel
 mappings
In-Reply-To: <1477048978-4140-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1477048978-4140-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161030144701.s7ntxfpavf5eyanl@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 12:22:55PM +0100, Ard Biesheuvel wrote:
> Ard Biesheuvel (3):
>   arm64: mm: BUG on unsupported manipulations of live kernel mappings
>   arm64: mm: replace 'block_mappings_allowed' with 'page_mappings_only'
>   arm64: mm: set the contiguous bit for kernel mappings where
>     appropriate

Queued for 4.10. Thanks.

-- 
Catalin
