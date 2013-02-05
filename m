From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 5 Feb 2013 09:08:40 +0800
Subject: [PATCH v8 08/12] pinctrl: generic: dump pin configuration
In-Reply-To: <20130205003535.GB25185@atomide.com>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-9-git-send-email-haojian.zhuang@linaro.org>
 <20130205003535.GB25185@atomide.com>
Message-ID: <CAD6h2NTjNphq0a=cssWDWtYVTaVSkjJsS2iY3D17COyHibhNJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 February 2013 08:35, Tony Lindgren <tony@atomide.com> wrote:
> * Haojian Zhuang <haojian.zhuang@linaro.org> [130202 09:30]:
>> @@ -114,4 +116,10 @@ static inline void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
>>       return;
>>  }
>>
>> +static void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
>> +                                     struct seq_file *s,
>> +                                     unsigned long config)
>> +{
>> +     return;
>> +}
>>  #endif
>
> This needs to be static inline void to avoid the following warning:
>
> drivers/pinctrl/pinconf.h:122: warning: ?pinconf_generic_dump_config? defined but not used
>
> Regards,
>
> Tony

Thanks. I'll update it.

Regards
Haojian
