From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 13 May 2015 07:17:25 +0530
Subject: [PATCH 1/3] ARM: exynos_defconfig: Enable CONFIG_SENSORS_PWM_FAN
 for odroidxu3 pmw-fan
In-Reply-To: <CAJKOXPcXRWm7T29LCYMMkW0FDF8LXEsAoMjwrTqBvSiQ+q5czg@mail.gmail.com>
References: <linux.amoon@gmail.com>
 <1431444262-29531-1-git-send-email-linux.amoon@gmail.com>
 <1431444262-29531-2-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPcXRWm7T29LCYMMkW0FDF8LXEsAoMjwrTqBvSiQ+q5czg@mail.gmail.com>
Message-ID: <CANAwSgSasMN-mgZWRg_FvnHL1AWf=wFRkUG4MP3JzieFF4NisQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Actually It's my mistake. This patch had double signed-off. So I
removed one from the patch.
Do I need to resend this.

-Anand Moon

On 13 May 2015 at 05:16, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> 2015-05-13 0:24 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>> Enable CONFIG_SENSORS_PWM_FAN on exynos_defconfig to control fan power on Odroidxu3.
>>
>> ---
>> Depends on http://www.spinics.net/lists/arm-kernel/msg412031.html
>> Tested on OdroidXU3 Board.
>> ---
>>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> This is mixed up. Try it yourself:
> 1. Save the email as mbox.
> 2. Apply with "git am" to a vanilla tree.
> Do you see the Signed-off-by in commit?
>
> Best regards,
> Krzysztof
