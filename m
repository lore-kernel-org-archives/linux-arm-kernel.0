From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Oct 2015 18:51:28 +0000
Subject: [PATCH] arm64: remove bogus TASK_SIZE_64 check
In-Reply-To: <1445831597-5680-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1445831597-5680-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151028185128.GI8899@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 12:53:17PM +0900, Ard Biesheuvel wrote:
> The comparison between TASK_SIZE_64 and MODULES_VADDR does not
> make any sense on arm64, it is simply something that has been
> carried over from the ARM port which arm64 is based on. So drop it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied. Thanks.

-- 
Catalin
