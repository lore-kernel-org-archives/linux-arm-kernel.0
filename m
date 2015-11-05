From: zhengxing@rock-chips.com (Xing Zheng)
Date: Thu, 05 Nov 2015 11:00:46 +0800
Subject: [PATCH v6 6/8] ARM: rockchip: add support smp for rk3036
In-Reply-To: <3167530.TSdLBvl1Zs@phil>
References: <1446639503-11763-1-git-send-email-zhengxing@rock-chips.com>
 <1446639916-11957-1-git-send-email-zhengxing@rock-chips.com>
 <3167530.TSdLBvl1Zs@phil>
Message-ID: <563AC65E.6050201@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?11?05? 07:33, Heiko Stuebner wrote:
> Am Mittwoch, 4. November 2015, 20:25:16 schrieb Xing Zheng:
>> From: Heiko Stuebner<heiko@sntech.de>
>>
>> The dual-core Cortex A7 rk3036 is a bit special in that it does not allow
>> to control the actual powerdomain of the cpu cores, while the rest of the
>> smp-bringup like reset control and entry address handling stays the same.
>> Its bigger sibling, the quad-core rk3128 again allows powerdomain control.
>>
>> So allow that case by introducing a separate smp-enable-method, that simply
>> disables powerdomain handling in the common code.
>>
>> Signed-off-by: Heiko Stuebner<heiko@sntech.de>
>> Tested-by: Xing Zheng<zhengxing@rock-chips.com>
>> Signed-off-by: Xing Zheng<zhengxing@rock-chips.com>
> This patch can work standalone, so I took the liberty of applying it to my soc
> branch for 4.5 already, so you don't need to resend it in future versions.
>
>
>
OK? thanks Heiko. :)
