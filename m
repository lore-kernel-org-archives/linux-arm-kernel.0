From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 19:28:41 +0200
Subject: [PATCH v2 1/8] watchdog: s3c2410: Remove confusing CONFIG prefix
 from local defines
In-Reply-To: <20170311172527.16368-2-krzk@kernel.org>
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-2-krzk@kernel.org>
Message-ID: <20170311172841.plxclb45qyp6yyqd@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 11, 2017 at 07:25:20PM +0200, Krzysztof Kozlowski wrote:
> The CONFIG prefix from defines in the s3c2410_wdt.c might suggest that
> these constants come from Kconfig.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/s3c2410_wdt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>

Ah, my mistake, I looked at watchdog-master but this is already in
watchdog-next. Sorry for confusion.

Best regards,
Krzysztof
