From: yong.shen@linaro.org (Yong Shen)
Date: Fri, 21 Jan 2011 15:36:24 +0100
Subject: [PATCH v2 1/4] ARM: i.MX53: enable spi support
In-Reply-To: <20110121104010.GE9041@pengutronix.de>
References: <1294750464-8660-1-git-send-email-yong.shen@freescale.com>
	<1294750464-8660-2-git-send-email-yong.shen@freescale.com>
	<20110121104010.GE9041@pengutronix.de>
Message-ID: <AANLkTi=uj82WjeK8kF8pvc-hGrL+J0S47LdNo+rGP7LG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Fri, Jan 21, 2011 at 11:40 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Jan 11, 2011 at 08:54:21PM +0800, yong.shen at freescale.com wrote:
>> From: Yong Shen <yong.shen@freescale.com>
>>
>> 1. register spi clock
>> 2. add macro definitions for spi platform data
>> 3. fix some bugs of register and iomux definition
>
> As I merged Dinhs patch for full iomux support this one won't apply
> anymore. Can you please rebase it onto imx-for-2.6.39?

You had already merged latest version (v3 or v4) of this into mainline, see:
467ae1e47fd44c44dd4972780c7a804f45be0fe8
6b2837dc6d7f923bd622049823284b7277ff0558
so we don't need this v2 patch anymore. And it seems that Dinh's iomux
definitions are also compatible with spi iomux.

Yong


>
> Sascha
>
