From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 05 Feb 2013 17:26:14 -0700
Subject: [GIT PULL 8/8] ARM: tegra: defconfig update
In-Reply-To: <20130205212604.GA30719@quad.lixom.net>
References: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
 <1359582159-28816-8-git-send-email-swarren@wwwdotorg.org>
 <20130205212604.GA30719@quad.lixom.net>
Message-ID: <5111A326.5050500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 02:26 PM, Olof Johansson wrote:
> On Wed, Jan 30, 2013 at 02:42:39PM -0700, Stephen Warren wrote:
>> Various new features are enabled on Tegra:
>> * RTC_DRV_TPS6586X to enable the RTC on many boards, such as Harmony
>>   and Ventana.
>> * POWER_RESET_GPIO to provide a power off driver for TrimSlice.
>> * Tegra KBC controller support, for Seaboard, Harmony, and Whistler.
>> * Tegra high-speed UART driver, for Cardhu Bluetooth.
>> * kexec support.
>>
>> This pull request is based on v3.8-rc3.
>>
>> ----------------------------------------------------------------
>>
>> The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:
>>
>>   Linux 3.8-rc3
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.9-defconfig
> 
> Pulled in 1-4,6-8 (since 6 contains 5 and saved some conflicts).

Thanks.

> There were a handful of conflicts during merge, please sanity-check the
> contents in arm-soc.

The merges look good, and the resultant arm-soc for-next branch works
fine on Tegra20 at least.
