From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 25 Aug 2014 11:18:54 +0200
Subject: [PATCH v7 1/8] clk: Add temporary mapping to the existing API
In-Reply-To: <20140821181007.GY12769@titan.lakedaemon.net>
References: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
 <1408375833-10703-2-git-send-email-tomeu.vizoso@collabora.com>
 <20140820145006.5251.30923@quantum> <20140821180448.GD10066@atomide.com>
 <20140821181007.GY12769@titan.lakedaemon.net>
Message-ID: <53FAFF7E.1030401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2014 08:10 PM, Jason Cooper wrote:
> On Thu, Aug 21, 2014 at 11:04:48AM -0700, Tony Lindgren wrote:
>> * Mike Turquette <mturquette@linaro.org> [140820 07:53]:
>>> Quoting Tomeu Vizoso (2014-08-18 08:30:27)
>>>> To preserve git-bisectability, add aliases from the future provider API to the
>>>> existing public API.
>>>>
>>>> Also includes clk-provider.h and clk-dev.h in a few places so the right
>>>> functions are defined.
>>>>
>>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>
>>> Cc'ing Tony for the OMAP2+ parts, Simon & Magnus for the SHMobile parts,
>>> Jason & Andrew for the Orion parts, Mauro & Kukjin for the Exynos parts.
>>>
>>> This change is super trivial but it's best not to touch these files
>>> without a heads-up for the owners.
>>
>> As long as it compiles omap2plus_defconfig it seems safe to me:
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>
> Same here for orion5x_defconfig, dove_defconfig, and mv78xx_defconfig.
>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
>
> Also, added Sebastian to the Cc as he's the maintainer of mach-berlin.

If it still compiles for multi_v7,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

I'll come back to mach-berlin later this week.

Sebastian
