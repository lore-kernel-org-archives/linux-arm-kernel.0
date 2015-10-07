From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 07 Oct 2015 10:36:54 +0900
Subject: [PATCH 4/6] ARM: s3c64xx: crag6410: Use PWM lookup table
In-Reply-To: <1444049237-29878-5-git-send-email-thierry.reding@gmail.com>
References: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
 <1444049237-29878-5-git-send-email-thierry.reding@gmail.com>
Message-ID: <56147736.2010208@samsung.com>
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
>  arch/arm/mach-s3c64xx/mach-crag6410.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
