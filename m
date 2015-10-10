From: timur@codeaurora.org (Timur Tabi)
Date: Sat, 10 Oct 2015 12:39:25 -0500
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <1442944788-17254-1-git-send-email-rric@kernel.org>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
Message-ID: <CAOZdJXXYXTCAJdFY2kkjtsX9RdsTePdo4eMRjRXFodiX=gaU5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 12:59 PM, Robert Richter <rric@kernel.org> wrote:
>
> -#define L1_CACHE_SHIFT         6
> +#define L1_CACHE_SHIFT         7
>  #define L1_CACHE_BYTES         (1 << L1_CACHE_SHIFT)

Would it be better if this were a Kconfig option, like it is on ARM32?

http://lxr.free-electrons.com/source/arch/arm/include/asm/cache.h#L7

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
