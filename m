From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 02 Apr 2015 14:18:34 +0200
Subject: [PATCH 2/2] ARM: dts: Enable S3C RTC on Trats2, Odroid-U3 and
 Arndale Octa
In-Reply-To: <1427972588-6573-2-git-send-email-k.kozlowski@samsung.com>
References: <1427972588-6573-1-git-send-email-k.kozlowski@samsung.com>
 <1427972588-6573-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <551D339A.5000808@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/02/2015 01:03 PM, Krzysztof Kozlowski wrote:
> Extend the S3C RTC node with rtc_src clock so it could be operational.
> The rtc_src clock is provided by MAX77686 (Trats2 and Odroid-U3) or
> S2MPS11 (Arndale Octa).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
