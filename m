From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 24 Aug 2015 09:51:11 +0200
Subject: [PATCH v2 1/5] clocksource: mediatek: do not enable GPT_CLK_EVT
 when setup
In-Reply-To: <1440167950.20169.29.camel@mtksdaap41>
References: <CAGS+omD8k_Cfxv3bYyjmjtLbiavo-WmJPn0Z-CBhN_nnv65Tag@mail.gmail.com>		
 <1437552878-3684-1-git-send-email-yingjoe.chen@mediatek.com>		
 <55CC56C4.8080201@linaro.org> <1439820602.3414.12.camel@mtksdaap41>	
 <55D5E40A.6080904@linaro.org> <1440167950.20169.29.camel@mtksdaap41>
Message-ID: <55DACCEF.8040004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2015 04:39 PM, Yingjoe Chen wrote:

[ ... ]

>>    - Does the spurious interrupt occurs *every* time ? at each boot ?
>
> Yes. If you applied this series to enable mtk timer without this fix on
> mt8173 or mt8135 you can reproduce it. It occurs for every boot.
>
> It crash before uart driver is ready, so you'll have to use earlycon to
> see the crash log.

Can you give me the earlycon params ?

Thanks.

  -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
