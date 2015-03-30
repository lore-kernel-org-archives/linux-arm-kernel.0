From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 31 Mar 2015 08:56:38 +0900
Subject: [PATCH v7 1/9] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <20150330160940.GA13731@leverpostej>
References: <1426637856-3730-1-git-send-email-cw00.choi@samsung.com>
 <1426637856-3730-2-git-send-email-cw00.choi@samsung.com>
 <20150330160940.GA13731@leverpostej>
Message-ID: <5519E2B6.2030905@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 03/31/2015 01:09 AM, Mark Rutland wrote:
> Hi,
> 
> On Wed, Mar 18, 2015 at 12:17:28AM +0000, Chanwoo Choi wrote:
>> This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC based on
>> Octal core CPUs (quad Cortex-A57 and quad Cortex-A53). And Exynos5433 supports
>> PSCI (Power State Coordination Interface) v0.1.
>>
>> This patch includes following dt node to support Exynos5433 SoC:
>> 1. Octa core for big.LITTLE architecture
>> - Cortex-A53 LITTLE Quad-core
>> - Cortex-A57 big Quad-core
>> - Support PSCI v0.1
> 
> Is CPU0 hotplug still broken, or has the FW been fixed?

CPU0 hotplug is still not working.

> 
> I'm very worried about adding a DT that's known broken, especially when
> we have no idea as to if/when the FW will be fixed judging from prior
> replies.

As I replied, I can not fix the FW because I don't have any code of FW.
I don't have any solution to fix it on Linux kernel level.

So, If you agree, I can add the comment of CPU0 hotplug issue on DT file.

Thanks,
Chanwoo Choi
