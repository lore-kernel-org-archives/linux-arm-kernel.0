From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 31 Aug 2016 16:45:34 +0200
Subject: [PATCH v8 04/11] power: act8945a_charger: Improve
In-Reply-To: <1472109599-21915-5-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472109599-21915-5-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160831144534.g6ylkq6hb5jmwhqt@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 25, 2016 at 03:19:52PM +0800, Wenyou Yang wrote:
> When get the property, first check the charger state machine,
> then check the status bit to decide what value is assigned to
> the corresponding property.
> 
> Retain the SUSCHG bit of REG 0x71 when configure the timers to
> avoid losting the charger suspending info after boot.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160831/79ee529d/attachment-0001.sig>
