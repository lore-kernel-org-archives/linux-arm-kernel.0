From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 5 May 2016 15:56:06 -0400
Subject: [RFC v2 10/13] usb: hub: Power sequence the ports on activation
In-Reply-To: <1462451666-17945-11-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-11-git-send-email-k.kozlowski@samsung.com>
Message-ID: <dd16f94c-9a4f-c197-7ca0-e1ff402feb98@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
> The autodetection of attached USB device might not work on certain
> boards where the power is delivered externally. These devices also might
> require a hard reset. Use pwrseq for that in USB hub.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Patch looks good to me. So after fixing the bisectability issue
pointed out by Alan Stern:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
