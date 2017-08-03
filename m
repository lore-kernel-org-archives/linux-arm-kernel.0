From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 03 Aug 2017 17:11:22 +0900
Subject: [PATCH 2/5] phy: rockchip-inno-usb2: Replace the extcon API
In-Reply-To: <06154871-a821-edab-23d8-340c5b0f5081@ti.com>
References: <1500254456-6525-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170717012058epcas1p157e9a296eb5e415ae24bb51a1e6026db@epcas1p1.samsung.com>
 <1500254456-6525-3-git-send-email-cw00.choi@samsung.com>
 <06154871-a821-edab-23d8-340c5b0f5081@ti.com>
Message-ID: <5982DAAA.8060201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2017? 08? 02? 14:12, Kishon Vijay Abraham I wrote:
> 
> 
> On Monday 17 July 2017 06:50 AM, Chanwoo Choi wrote:
>> This patch uses the resource-managed extcon API for extcon_register_notifier()
>> and replaces the deprecated extcon API as following:
>> - extcon_get_cable_state_() -> extcon_get_state()
>> - extcon_set_cable_state_() -> extcon_set_state_sync()
>>
>> Cc: linux-rockchip at lists.infradead.org
>> acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>   ^
> should be 'A' here.

My mistake. I'll fix it.

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
