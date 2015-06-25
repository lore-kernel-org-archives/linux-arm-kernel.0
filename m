From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 25 Jun 2015 11:18:13 +0200
Subject: [PATCH v2 7/9] ARM: multi_v7_defconfig: Enable support for PWM
 Regulators
In-Reply-To: <20150625084204.GW15013@x1>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
 <1435154348-28840-8-git-send-email-lee.jones@linaro.org>
 <CABxcv==J2hi0y+=s3nK_U=-jkjTW3L9jCC2JfebnWwRfpDGLAQ@mail.gmail.com>
 <20150625084204.GW15013@x1>
Message-ID: <CABxcv==_YZ7BCCzfbLXYxwUL_kKLtBxOVTCvcUnvGVnrD4bVpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

On Thu, Jun 25, 2015 at 10:42 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 24 Jun 2015, Javier Martinez Canillas wrote:

[...]

>> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> > index f632af0..6666973 100644
>> > --- a/arch/arm/configs/multi_v7_defconfig
>> > +++ b/arch/arm/configs/multi_v7_defconfig
>> > @@ -365,6 +365,7 @@ CONFIG_REGULATOR_MAX8907=y
>> >  CONFIG_REGULATOR_MAX8973=y
>> >  CONFIG_REGULATOR_MAX77686=y
>> >  CONFIG_REGULATOR_PALMAS=y
>> > +CONFIG_REGULATOR_PWM=y
>>
>> The current policy is to build as much as possible as a module in
>> multi_v7_defconfig. Since this is a tristate Kconfig symbol, could you
>> please change it to =m ?
>
> I would prefer that it stays built-in.
>

Ok, I've no strong opinion on this. I was just mentioning what arm-soc
maintainers prefer nowadays.

May I ask what's the rationale for leaving this option built-in?

Best regards,
Javier
