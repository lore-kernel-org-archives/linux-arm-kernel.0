From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 16 Dec 2015 08:50:10 +0800
Subject: [PATCH v10 0/17] Add Analogix Core Display Port Driver
In-Reply-To: <4659407.pYb0RRCQQX@diego>
References: <1449470239-30667-1-git-send-email-ykk@rock-chips.com>
 <4659407.pYb0RRCQQX@diego>
Message-ID: <5670B542.4060402@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 12/15/2015 08:06 AM, Heiko St?bner wrote:
> Hi Yakir,
>
> Am Montag, 7. Dezember 2015, 14:37:19 schrieb Yakir Yang:
>>     The Samsung Exynos eDP controller and Rockchip RK3288 eDP controller
>> share the same IP, so a lot of parts can be re-used. I split the common
>> code into bridge directory, then rk3288 and exynos only need to keep
>> some platform code. Cause I can't find the exact IP name of exynos dp
>> controller, so I decide to name dp core driver with "analogix" which I
>> find in rk3288 eDP TRM
> so it looks like the hotplug works nicely now. I was able to test it
> sucessfully on both a Jerry and a Minnie device without needing to force
> hotplug :-) .
>
> As I needed to adapt some patches when applying the lastest ones, I think it
> would be good for a full send of the latest version as v11.

Got it, will send soon  ;)

> When going over the patches before sending, please also fix the indentation
> issues in analogix_dp_core.h - both newly added elements to analogix_dp_device
> use spaces between type and name, where the rest uses tabs.
> [This should of course be fixed in the patches adding these lines :-) ]

Done,

Thanks,
- Yakir

>
> Heiko
>
>
>
