From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 10 Apr 2016 18:28:17 +0200
Subject: [PATCH] sbs-battery: fix power status when battery charging near
 dry
In-Reply-To: <1459909945-36541-1-git-send-email-yh.huang@mediatek.com>
References: <1459909945-36541-1-git-send-email-yh.huang@mediatek.com>
Message-ID: <20160410162817.GD25923@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 06, 2016 at 10:32:25AM +0800, YH Huang wrote:
> POWER_SUPPLY_STATUS_NOT_CHARGING is used for AC connected, but
> battery not charging (e.g. because battery temperature is out
> of acceptable range).
> 
> When battery is charging near dry and BATTERY_FULL_DISCHARGED is set,
> it is wrong to set as POWER_SUPPLY_STATUS_NOT_CHARGING.
> Just use BATTERY_DISCHARGING to decide the power supply status is
> discharging or charging.

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160410/701fcaea/attachment.sig>
