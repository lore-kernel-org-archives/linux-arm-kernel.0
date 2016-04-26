From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 26 Apr 2016 18:09:53 +0100
Subject: [GIT PULL v3] arm64: hisilicon: config changes for 4.7
In-Reply-To: <4910387.g0H3XLnE4p@wuerfel>
References: <571F3CB8.3000904@hisilicon.com> <4910387.g0H3XLnE4p@wuerfel>
Message-ID: <571FA0E1.2010901@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 26/04/2016 12:04, Arnd Bergmann wrote:
> On Tuesday 26 April 2016 11:02:32 Wei Xu wrote:
>> Please help to pull the following changes.
>>
>> I rebased this pull request on v4.6-rc3 but I found
>> it is same with the v2 that based on v4.6-rc4.
>> Is it OK or should I base on earlier -rc version like rc1?
> 
> Looks good now.  What is important to me is that I don't pull
> in a later -rc release from mainline than what I already have
> in arm-soc, if at all possible.

Got it.

> 
>> The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:
>>
>>   Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)
>>
>> are available in the git repository at:
>>
>>   git://github.com/hisilicon/linux-hisi.git tags/hi6220-config-for-4.7v3
>>
>> for you to fetch changes up to 2b905d3a8d7e40c3486abbf585419fafa220a8f8:
>>
>>   arm64: Kconfig: select sp804 timer for ARCH_HISI (2016-04-26 10:39:09 +0100)
>>
>> ----------------------------------------------------------------
>> ARM64: Hi6220: configure updates for 4.7 based on rc3
>>
>> - Enable Hi655x PMIC and regulator
>> - Enable SPI_SPIDEV as module
>> - Enable several common USB-Ethernet dongles
>> - Enable configs for WLAN and TI WL1835 as modules
>> - Enable ARM SP804 for ARCH_HISI
>>
> 
> Pulled into next/arm64, thanks for the rebase!

Thanks!

Best Regards,
Wei

> 
> 	Arnd
> 
> .
> 
