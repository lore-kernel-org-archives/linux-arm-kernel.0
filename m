From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 24 Jan 2011 11:19:52 -0800
Subject: [PATCH v4 01/19] ARM: Make the argument to virt_to_phys() "const
	volatile"
In-Reply-To: <1295891761-18366-2-git-send-email-catalin.marinas@arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-2-git-send-email-catalin.marinas@arm.com>
Message-ID: <4D3DD0D8.10905@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2011 09:55 AM, Catalin Marinas wrote:
> Changing the virt_to_phys() argument to "const volatile void *" avoids
> compiler warnings in some situations where this function is used.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Any chance we can get this one patch into 2.6.38? It fixes a warning for
MSM.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
