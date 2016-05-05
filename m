From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 5 May 2016 15:33:38 -0400
Subject: [RFC v2 08/13] usb: hub: Handle deferred probe
In-Reply-To: <1462451666-17945-9-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-9-git-send-email-k.kozlowski@samsung.com>
Message-ID: <0a751690-a506-34b8-9435-289cf016b756@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
> Add support for deferred probing to the usb hub. Currently EPROBE_DEFER
> does not exist in usb hub path but future patches will add it on the
> port level.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
