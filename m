From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 15 Apr 2016 10:17:17 +0200
Subject: [PATCH v5 16/24] ARM: explicitly apply PWM config extracted from
 pwm_args
In-Reply-To: <1460661464-11216-17-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
 <1460661464-11216-17-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <5710A38D.3050202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2016 09:17 PM, Boris Brezillon wrote:
> Call pwm_apply_args() just after requesting the PWM device so that the
> polarity and period are initialized according to the information provided
> in pwm_args.
> 
> This is an intermediate state, and pwm_apply_args() should be dropped as
> soon as the atomic PWM infrastructure is in place and the driver makes
> use of it.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  arch/arm/mach-s3c24xx/mach-rx1950.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
