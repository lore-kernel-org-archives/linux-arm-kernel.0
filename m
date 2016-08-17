From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 17 Aug 2016 13:47:53 +0200
Subject: [PATCH v5 5/7] power: act8945a_charger: Add capacity level
 property
In-Reply-To: <1471337998-6467-6-git-send-email-wenyou.yang@atmel.com>
References: <1471337998-6467-1-git-send-email-wenyou.yang@atmel.com>
 <1471337998-6467-6-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160817114753.copygtkdmnohhybr@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 16, 2016 at 04:59:56PM +0800, Wenyou Yang wrote:
> Add the power supply capacity level property, it corresponds to
> POWER_SUPPLY_CAPACITY_LEVEL_*.
> 
> It also utilizes the precision voltage detector function module
> to catch the low battery voltage.

Please use gpiod API instead of old gpio API.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160817/ee1ffc59/attachment.sig>
