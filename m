From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Mon, 8 Feb 2016 10:52:17 +0300
Subject: [PATCH] arm64: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
In-Reply-To: <1454716218-4918-1-git-send-email-yang.shi@linaro.org>
References: <1454716218-4918-1-git-send-email-yang.shi@linaro.org>
Message-ID: <56B84931.5080407@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2016 02:50 AM, Yang Shi wrote:
> To enable UBSAN on arm64, ARCH_HAS_UBSAN_SANITIZE_ALL need to be selected.
> 
> Basic kernel bootup test is passed on arm64 with CONFIG_UBSAN_SANITIZE_ALL
> enabled.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---


Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
