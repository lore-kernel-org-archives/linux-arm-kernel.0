From: mark.yao@rock-chips.com (Mark yao)
Date: Thu, 18 Feb 2016 10:54:02 +0800
Subject: [PATCH v8.1 1/2] drm/rockchip: hdmi: add Innosilicon HDMI support
In-Reply-To: <3883951.Go5JsyhPRt@phil>
References: <1454049768-30872-1-git-send-email-ykk@rock-chips.com>
 <1454492697-7837-1-git-send-email-ykk@rock-chips.com>
 <3883951.Go5JsyhPRt@phil>
Message-ID: <56C5324A.5080009@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?02?18? 05:00, Heiko Stuebner wrote:
> Am Mittwoch, 3. Februar 2016, 17:44:57 schrieb Yakir Yang:
>> The Innosilicon HDMI is a low power HDMI 1.4 transmitter
>> IP, and it have been integrated on some rockchip CPUs
>> (like RK3036, RK312x).
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> On a Kylin board against 4.5-rc
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Good, Thanks your Tested-by.

> @Mark: While testing I noticed a black box around my cursor. It moves with
> the cursor, so seems to be the plane itself - the hdmi driver is of course
> innocent. May there exist an issue with plane transparency?

Oh, yes, it's my problem, forget to add transparency for rk3036 plane, I 
will do it later soon.

>
>
> Heiko
>
>
>

-- 
?ark Yao
