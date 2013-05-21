From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Tue, 21 May 2013 07:56:21 +0000
Subject: [PATCH v3 1/2] pinctrl: add MVF600 pinctrl driver
In-Reply-To: <CAAQ0ZWSZeqOEceN-KmDS4_BT27_4xCYjfFMj8sHkEonOXaoF_g@mail.gmail.com>
References: <1368685224-17915-1-git-send-email-b35083@freescale.com>
 <20130520033207.GD25113@S2101-09.ap.freescale.net>
 <CAAQ0ZWSZeqOEceN-KmDS4_BT27_4xCYjfFMj8sHkEonOXaoF_g@mail.gmail.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CBBA4@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Monday, May 20, 2013 11:52 AM
>To: Lu Jingchang-B35083
>Cc: linux-arm-kernel; Linus Walleij; Sascha Hauer
>Subject: Re: [PATCH v3 1/2] pinctrl: add MVF600 pinctrl driver
>
>On 20 May 2013 11:32, Shawn Guo <shawn.guo@linaro.org> wrote:
>>> +static struct imx_pinctrl_soc_info mvf600_pinctrl_info = {
>>> +     .pins = mvf600_pinctrl_pads,
>>> +     .npins = ARRAY_SIZE(mvf600_pinctrl_pads),
>>> +     .flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG,
>>
>> The flags should be introduced in the same patch where they are used
>> in the first place.
>>
>I just found what you need to do is just to reverse the patch order,
>having this patch be the second one.
>
[Lu Jingchang-B35083] 
I see you have Acked [PATCH v3 2/2] pinctrl: imx: add MVF600 support to imx pinctrl framework, do I need resend it as the first one. Thanks!
