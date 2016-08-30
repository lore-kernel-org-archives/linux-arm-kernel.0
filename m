From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 30 Aug 2016 09:04:52 +0200
Subject: [PATCH 0/4 v3] Add a new board TOPEET iTOP for exynos 4412
In-Reply-To: <1472383269-3126-1-git-send-email-ayaka@soulik.info>
References: <CAL_JsqKY=VEZ+U11kY+XbMWuXhaFDr6GpnR3AXKd1U=9_=8fgA@mail.gmail.com>
 <1472383269-3126-1-git-send-email-ayaka@soulik.info>
Message-ID: <babd37da-371a-3530-0ac5-502f3297239d@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2016 01:21 PM, Randy Li wrote:
> The added the audio codec seems work now, but the audio sounds
> still a little different to the original. But I didn't hear the sound
> in the Android, I don't know whether it is qualified.
> 
> Also it lacks of full pinctrl for the sleep state.
> 
> Changelog:
>  - v3:
>    - fixing the rtc clock, using clock source from PMIC
>    - enable the tmu
>    - enable the fimc for elite board
>    - suuport the audio codec at elite board
>    - fixing minor bugs in the last commit
>  - v2:
>    - removing rtc node
>      the clock source driver is not done yet.
>    - adding exynos-bus
>    - fixing the MFC

The way you send emails is really messed up.
1. The v3 in "PATCH v3" should be present in all patches. Use -v3 for
format-patch.

2. Don't reply-in-to old thread. All your new patches are now under old
ones. They have same subject so this is highly confusing. I don't have a
clue which is a new one.

Best regards,
Krzysztof
