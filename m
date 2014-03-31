From: zhangfei.gao@linaro.org (zhangfei)
Date: Mon, 31 Mar 2014 10:45:29 +0800
Subject: [PATCH 2/3] net: hisilicon: new hip04 MDIO driver
In-Reply-To: <20140330.172313.2128642789143277676.davem@davemloft.net>
References: <1396020960-6170-1-git-send-email-zhangfei.gao@linaro.org>	<1396020960-6170-3-git-send-email-zhangfei.gao@linaro.org>
 <20140330.172313.2128642789143277676.davem@davemloft.net>
Message-ID: <5338D6C9.4060404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/31/2014 05:23 AM, David Miller wrote:
> From: Zhangfei Gao <zhangfei.gao@linaro.org>
> Date: Fri, 28 Mar 2014 23:35:59 +0800
>
>> +	  Note that the answer to this question doesn't directly affect the
>> +	  kernel: saying N will just cause the configurator to skip all
>> +	  the questions about MOXA ART devices. If you say Y, you will be asked
>> +	  for your specific card in the following questions.
>
> Please don't just cut and paste things from unrelated Kconfig entries.
>
> This Kconfig option has nothing to do with MOXA ART devices.
>
My bad, will update in new version.
