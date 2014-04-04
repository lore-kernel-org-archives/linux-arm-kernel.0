From: zhangfei.gao@linaro.org (zhangfei)
Date: Fri, 04 Apr 2014 23:40:24 +0800
Subject: [PATCH 2/3] net: hisilicon: new hip04 MDIO driver
In-Reply-To: <20140404.113010.1212333214715849484.davem@davemloft.net>
References: <1396624597-390-1-git-send-email-zhangfei.gao@linaro.org>	<1396624597-390-3-git-send-email-zhangfei.gao@linaro.org>
 <20140404.113010.1212333214715849484.davem@davemloft.net>
Message-ID: <533ED268.9090502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/04/2014 11:30 PM, David Miller wrote:
> From: Zhangfei Gao <zhangfei.gao@linaro.org>
> Date: Fri,  4 Apr 2014 23:16:36 +0800
>
>> +config HIP04_ETH
>> +	tristate "HISILICON P04 Ethernet support"
>> +	select NET_CORE
>> +	select PHYLIB
>> +	select MARVELL_PHY
>> +	select MFD_SYSCON
>> +	---help---
>> +	  If you wish to compile a kernel for a hardware with hisilicon p04 SoC and
>> +	  want to use the internal ethernet then you should answer Y to this.
>
> Selecting NET_CORE makes no sense, if it's not set this driver's
> Kconfig file won't even be considered.
>

Thanks Daivd, could I update following this thread first.
