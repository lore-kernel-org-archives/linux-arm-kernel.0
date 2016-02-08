From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Feb 2016 18:15:53 +0000
Subject: [PATCH] arm64: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
In-Reply-To: <1454716218-4918-1-git-send-email-yang.shi@linaro.org>
References: <1454716218-4918-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20160208181553.GX6076@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 03:50:18PM -0800, Yang Shi wrote:
> To enable UBSAN on arm64, ARCH_HAS_UBSAN_SANITIZE_ALL need to be selected.
> 
> Basic kernel bootup test is passed on arm64 with CONFIG_UBSAN_SANITIZE_ALL
> enabled.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>

Applied. Thanks.

-- 
Catalin
