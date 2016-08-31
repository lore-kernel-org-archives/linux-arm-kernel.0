From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 31 Aug 2016 16:45:13 +0200
Subject: [PATCH v8 03/11] power: act8945a_charger: Remove
 "battery_temperature"
In-Reply-To: <1472109599-21915-4-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472109599-21915-4-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160831144513.rrngdcjfsg5swmw6@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 25, 2016 at 03:19:51PM +0800, Wenyou Yang wrote:
> Remove "battery_temperature" member, it is redundant, it is the
> hardware's responsibility to handle TH pin properly.
> It is unnecessary to use the dt property to check if there is
> a battery temperature monitor or not.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160831/4e6a31d2/attachment.sig>
