From: wxt@rock-chips.com (Caesar Wang)
Date: Sat, 14 Nov 2015 14:30:46 +0800
Subject: [PATCH v4 00/10] Better compatible for the rockchip thermal and
 support RK3368 SoCs
In-Reply-To: <20151112182950.GB4361@localhost.localdomain>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
 <20151112182950.GB4361@localhost.localdomain>
Message-ID: <5646D516.9040404@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eduardo,

? 2015?11?13? 02:29, Eduardo Valentin ??:
> On Mon, Nov 09, 2015 at 12:48:52PM +0800, Caesar Wang wrote:
>> Thank you all for providing inputs and comments on previous versions of
>> this patchset.
>> Especially thanks to the (Eduardo, Dmitry, Heiko,....).
>>
>> This series patchs are working for RK3368 on Rockchip platform.
> Do you have any results on existing support? Is the driver still in one
> piece for rk3288?

Yep. that's still happy work for rk3288 SoCs.

$while true; do grep "" /sys/class/thermal/thermal_zone[1-2]/temp; sleep 
.5; done
...
/sys/class/thermal/thermal_zone1/temp:70833
/sys/class/thermal/thermal_zone2/temp:69615
/sys/class/thermal/thermal_zone1/temp:70416
/sys/class/thermal/thermal_zone2/temp:68846
/sys/class/thermal/thermal_zone1/temp:70416
/sys/class/thermal/thermal_zone2/temp:70833
/sys/class/thermal/thermal_zone1/temp:70833
/sys/class/thermal/thermal_zone2/temp:69615
/sys/class/thermal/thermal_zone1/temp:71666
/sys/class/thermal/thermal_zone2/temp:69615
/sys/class/thermal/thermal_zone1/temp:70416
/sys/class/thermal/thermal_zone2/temp:69615
/sys/class/thermal/thermal_zone1/temp:70833

> I am planing to send your series in next rc cycles. It won't appear in
> linux-next until merge window finishes.

Thanks!
>
> BR,
>
> Eduardo Valentin
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
caesar wang | software engineer | wxt at rock-chip.com
