From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 May 2013 11:51:59 +0800
Subject: [PATCH v3 1/2] pinctrl: add MVF600 pinctrl driver
In-Reply-To: <20130520033207.GD25113@S2101-09.ap.freescale.net>
References: <1368685224-17915-1-git-send-email-b35083@freescale.com>
 <20130520033207.GD25113@S2101-09.ap.freescale.net>
Message-ID: <CAAQ0ZWSZeqOEceN-KmDS4_BT27_4xCYjfFMj8sHkEonOXaoF_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 May 2013 11:32, Shawn Guo <shawn.guo@linaro.org> wrote:
>> +static struct imx_pinctrl_soc_info mvf600_pinctrl_info = {
>> +     .pins = mvf600_pinctrl_pads,
>> +     .npins = ARRAY_SIZE(mvf600_pinctrl_pads),
>> +     .flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG,
>
> The flags should be introduced in the same patch where they are used
> in the first place.
>
I just found what you need to do is just to reverse the patch order,
having this patch be the second one.

Shawn
