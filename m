From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 31 Aug 2016 16:48:18 +0200
Subject: [PATCH v8 10/11] doc: bindings: power: act8945a-charger: Update
 properties.
In-Reply-To: <1472110826-22328-1-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472110826-22328-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160831144818.b3i4fplqsfom7uql@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 25, 2016 at 03:40:26PM +0800, Wenyou Yang wrote:
> Due the driver improvements, update the properties,
>  - Remove "active-semi,check-battery-temperature" property.
>  - Add the properties, "active-semi,irq_gpio"
>    and "active-semi,lbo-gpios".
>  - As act8945a-charger is regarded as a sub-device, update
>    the compatible and examples.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160831/a114ff92/attachment.sig>
