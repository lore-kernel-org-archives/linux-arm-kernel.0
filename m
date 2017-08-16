From: hjc@rock-chips.com (Sandy Huang)
Date: Wed, 16 Aug 2017 14:06:55 +0800
Subject: [PATCH v5 3/3] drm/rockchip: Add support for Rockchip Soc LVDS
In-Reply-To: <3e6822fa-58f6-9207-32b1-340e330bf758@phytec.de>
References: <1502768955-176510-1-git-send-email-hjc@rock-chips.com>
 <1502768969-176681-1-git-send-email-hjc@rock-chips.com>
 <3e6822fa-58f6-9207-32b1-340e330bf758@phytec.de>
Message-ID: <64900a7a-25d1-2822-1fc1-0b5fe4b08752@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017/8/15 17:08, Wadim Egorov ??:
> 
> 
> Am 15.08.2017 um 05:49 schrieb Sandy Huang:
>> This adds support for Rockchip soc lvds found on rk3288
>> Based on the patches from Mark yao and Heiko Stuebner
>>
>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>   drivers/gpu/drm/rockchip/Kconfig            |   9 +
>>   drivers/gpu/drm/rockchip/Makefile           |   1 +
>>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   2 +
>>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
>>   drivers/gpu/drm/rockchip/rockchip_lvds.c    | 599 ++++++++++++++++++++++++++++
>>   drivers/gpu/drm/rockchip/rockchip_lvds.h    | 109 +++++
>>   6 files changed, 721 insertions(+)
>>   create mode 100644 drivers/gpu/drm/rockchip/rockchip_lvds.c
>>   create mode 100644 drivers/gpu/drm/rockchip/rockchip_lvds.h
>>
> I have tested this with an ETM0700G0DH6 7.0" LCD panel on the
> phyCORE-RK3288.
> 
> Tested-by: Wadim Egorov <w.egorov@phytec.de>
> 
> 
> 
Hi Wadim Egorov,
     Thanks for your test.
