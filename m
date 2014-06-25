From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 25 Jun 2014 20:41:26 +0800
Subject: [PATCH v2 1/2] Documentation: Document Hisilicon hix5hd2 sata PHY
In-Reply-To: <201406251416.49561.arnd@arndb.de>
References: <1403687648-29082-1-git-send-email-zhangfei.gao@linaro.org>
 <1403687648-29082-2-git-send-email-zhangfei.gao@linaro.org>
 <201406251416.49561.arnd@arndb.de>
Message-ID: <53AAC376.7050705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/25/2014 08:16 PM, Arnd Bergmann wrote:
> On Wednesday 25 June 2014, Zhangfei Gao wrote:
>> From: Jiancheng Xue <xuejiancheng@huawei.com>
>>
>> Add necessary binding documentation SATA PHY on Hisilicon hix5hd2 soc.
>>
>> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>
> We have had a couple of PHY drivers that were initially meant to be
> single-purpose but then turned out to be for hardware that could
> be put into multiple modes (SATA, gbit ethernet, PCIe, ...). Are
> you sure that this particular device is SATA-only?
>

Yes, double confimed.
Hix5hd2 phy diver only support sata phy, in fact, current soc only 
support synposis phy, since some internal physical link.
And hix5hd2 ethernet phy is already in hix5hd2_gmac.c.
No pcie support on hix5hd2 platfrom.

Thanks
