From: tengfei@codeaurora.org (tengfei at codeaurora.org)
Date: Mon, 05 Nov 2018 16:21:48 +0800
Subject: [PATCH] arm: kernel: add support for detecting armv8 cpu cache
 information
In-Reply-To: <20181018085609.GI30658@n2100.armlinux.org.uk>
References: <1539843407-7439-1-git-send-email-tengfei@codeaurora.org>
 <20181018085609.GI30658@n2100.armlinux.org.uk>
Message-ID: <8a260ff92ceaf2c673327fd390780434@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

     our team team was trying to check L1, L2 cache size with adb 
commands help on 32bit ARMv8 platform, so we submit this patch.

Thanks,
Tengfei Fan

On 2018-10-18 16:56, Russell King - ARM Linux wrote:
> On Thu, Oct 18, 2018 at 02:16:47PM +0800, Teng Fei Fan wrote:
>> This patch adds support for cacheinfo on 32bit ARMv8 platform.
>> Add support for detecting cpu cache information cpu cache information
>> via sysfs for 32bit armv8 platform. And export to sysfs then userspace
>> can get from /sys/devices/system/cpu/cpuX/cache.
> 
> You don't explain why this is needed.
> 
> We don't do this for previous 32-bit CPUs, so why should we do this
> for ARMv8 running on a 32-bit kernel?
