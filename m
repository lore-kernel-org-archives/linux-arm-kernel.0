From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 08 Oct 2015 10:00:44 +0900
Subject: [PATCH 3/6] ARM: s3c64xx: smdk6410: Use PWM lookup table
In-Reply-To: <1444049237-29878-4-git-send-email-thierry.reding@gmail.com>
References: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
 <1444049237-29878-4-git-send-email-thierry.reding@gmail.com>
Message-ID: <5615C03C.5090803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.10.2015 21:47, Thierry Reding wrote:
> Use a PWM lookup table to provide the PWM to the pwm-backlight device.
> The driver has a legacy code path that is required only because boards
> still use the legacy method of requesting PWMs by global ID. Replacing
> these usages allows that legacy fallback to be removed.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/dev-backlight.c | 4 ----
>  arch/arm/mach-s3c64xx/mach-smdk6410.c | 8 +++++++-
>  2 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
