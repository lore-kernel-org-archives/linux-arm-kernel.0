From: hs@denx.de (Heiko Schocher)
Date: Fri, 20 Jun 2014 16:24:32 +0200
Subject: [PATCH] arm, imx6, dts: add aristainetos board support
In-Reply-To: <20140620130628.GK28225@dragon>
References: <1402468548-17539-1-git-send-email-hs@denx.de>
 <20140618132915.GK8860@dragon> <53A2C8DD.7000601@denx.de>
 <20140620130628.GK28225@dragon>
Message-ID: <53A44420.6010106@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shwan,

Am 20.06.2014 15:06, schrieb Shawn Guo:
> On Thu, Jun 19, 2014 at 01:26:21PM +0200, Heiko Schocher wrote:
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 =<&pinctrl_hog&pinctrl_backlight&pinctrl_gpio>;
>>>
>>> pinctrl_backlight and pinctrl_gpio shouldn't be in there.
>>
>> removed&pinctrl_backlight, removed device specific gpios to
>> device nodes ... but there are some gpios only used with GPIO API ...
>>
>> Where to move this pinctrls ?
>
> For GPIO that do not have a clear client device owing, it's fine to have
> it in hog group.

Ok, so I put them back to the DTS.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
