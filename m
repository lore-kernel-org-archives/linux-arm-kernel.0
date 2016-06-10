From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jun 2016 13:43:29 +0200
Subject: [RFC PATCH 02/15] clocksource: samsung_pwm_timer: fix endian
 accessors
In-Reply-To: <20160608183110.13851-3-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
 <20160608183110.13851-3-matthew@mattleach.net>
Message-ID: <575AA7E1.9030000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2016 08:30 PM, Matthew Leach wrote:
> Fix the Samsung pwm timer access code to deal with kernels built for big
> endian operation.
> 
> Signed-off-by: Matthew Leach <matthew@mattleach.net>
> ---
> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: linux-kernel at vger.kernel.org
> ---
>  drivers/clocksource/samsung_pwm_timer.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
