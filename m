From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 17 Aug 2016 13:51:37 +0200
Subject: [PATCH v5 6/7] power: act8945a_charger: Add max current property
In-Reply-To: <1471337998-6467-7-git-send-email-wenyou.yang@atmel.com>
References: <1471337998-6467-1-git-send-email-wenyou.yang@atmel.com>
 <1471337998-6467-7-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160817115137.sldoet7dfxeusoxm@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 16, 2016 at 04:59:57PM +0800, Wenyou Yang wrote:
> Add the power supply's current max property,
> POWER_SUPPLY_PROP_CURRENT_MAX.

Please also switch chgin_level to gpiod API.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160817/e215d0f0/attachment-0001.sig>
