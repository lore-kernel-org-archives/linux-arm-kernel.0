From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Nov 2014 09:02:08 -0800
Subject: [PATCH v3 2/2] ARM: EXYNOS: Call regulator core suspend prepare
 and finish functions
In-Reply-To: <CABxcv=mMqh5UD0_Wz3rNaFbZD3BH_2Z+7srzccd=-5_ndo_a1Q@mail.gmail.com>
References: <1413839151-10875-1-git-send-email-javier.martinez@collabora.co.uk>
 <1413839151-10875-3-git-send-email-javier.martinez@collabora.co.uk>
 <CABxcv==YZjO9p3aNyuRpe3DYS+=BcY_N2esuTg0hGASb_b_OdA@mail.gmail.com>
 <CABxcv=mMqh5UD0_Wz3rNaFbZD3BH_2Z+7srzccd=-5_ndo_a1Q@mail.gmail.com>
Message-ID: <CAOesGMjKP6Yg-M_7Zy5bbEJ7QD7fQ27Bopd6yD3M=r=4SArR6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 2:23 AM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> Hello Kukjin,
>
> On Thu, Oct 30, 2014 at 11:06 AM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
>> Hello Kukjin,
>>
>> On Mon, Oct 20, 2014 at 11:05 PM, Javier Martinez Canillas
>> <javier.martinez@collabora.co.uk> wrote:
>>> The regulator framework has a set of helpers functions to be used when
>>> the system is entering and leaving from suspend but these are not called
>>> on Exynos platforms. This means that the .set_suspend_* function handlers
>>> defined by regulator drivers are not called when the system is suspended.
>>>
>>> Suggested-by: Doug Anderson <dianders@chromium.org>
>>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>>> ---
>>>  arch/arm/mach-exynos/suspend.c | 23 +++++++++++++++++++++++
>>>  1 file changed, 23 insertions(+)
>>>
>>
>> Any comments on this patch?
>>
>
> Just a gentle reminder about this patch.

Kukjin, should I just apply this directly since you seem to be busy?


Thanks,

-Olof
