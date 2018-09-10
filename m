From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 10 Sep 2018 19:22:55 +0200
Subject: [PATCH v3 2/2] ARM: s3c24xx: Correct SD card write protect
 detection on Mini2440
In-Reply-To: <20180907215446.15160-2-sed@free.fr>
References: <20180907215446.15160-1-sed@free.fr>
 <20180907215446.15160-2-sed@free.fr>
Message-ID: <20180910172255.yeqe4d263vj7n6ge@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 11:54:46PM +0200, Cedric Roux wrote:
> The mini2440 computer uses "active high" to signal that the "write protect"
> of the inserted MMC is set. The current code uses the opposite, leading to
> a wrong detection of write protection. The solution is simply to use
> ".wprotect_invert = 1" in the description of the MMC.
> 
> Signed-off-by: Cedric Roux <sed@free.fr>
> ---
>  arch/arm/mach-s3c24xx/mach-mini2440.c | 9 +++++----

Thanks, applied.

Best regards,
Krzysztof
