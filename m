From: caesar.upstream@gmail.com (Caesar Wang)
Date: Sun, 21 Feb 2016 10:18:41 +0800
Subject: [PATCH v5 1/8] ARM: dts: rockchip: add hdmi/vop device node for
 rk3036
In-Reply-To: <6774166.XfKvalhQ7F@phil>
References: <1454384032-6794-1-git-send-email-wxt@rock-chips.com>
 <1454384453-7127-1-git-send-email-wxt@rock-chips.com>
 <6774166.XfKvalhQ7F@phil>
Message-ID: <56C91E81.2090803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016?02?21? 08:03, Heiko Stuebner ??:
> Am Dienstag, 2. Februar 2016, 11:40:50 schrieb Caesar Wang:
>> This patch adds the needed display info for rk3036 SOCs.
>>
>> The rk3036 support two overlay plane and one hwc plane,
>> it supports IOMMU, and its IOMMU same as rk3288's.
>> Meanwhile, add the inno hdmi for HDMI display.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> I've split this into 3 patches (vop, hdmi, kylin enablement) and applied
> this to my dts32 branch.

That's great, thanks.


>
> Heiko
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
Thanks,
Caesar
