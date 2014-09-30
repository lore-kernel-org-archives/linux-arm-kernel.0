From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 30 Sep 2014 22:34:20 +0200
Subject: [PATCH 1/2] tty: serial: samsung: Clean-up selection of number
 of available UARTs
In-Reply-To: <1412087695-10591-1-git-send-email-a.kesavan@samsung.com>
References: <1412087695-10591-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <542B13CC.8000809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash,

On 30.09.2014 16:34, Abhilash Kesavan wrote:
> Remove symbols SERIAL_SAMSUNG_UARTS_4 and SERIAL_SAMSUNG_UARTS which
> select the number of UART ports available on the SoC. Use the maximum
> number of UART ports possible across the serial driver in place of
> SERIAL_SAMSUNG_UARTS. Removal of these symbols also helps in Exynos7
> serial enablement.
> 

AFAICT this patch should be second in the series, because it removes
symbols which are used by code that is yet to be updated in current patch 2.

Otherwise:

Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
