From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 5 Nov 2018 09:54:36 +0000
Subject: [GIT PULL] sprd dts for kernel v4.20-rc1
In-Reply-To: <20181102183246.r5xxwsic2mxwihsi@localhost>
References: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com>
 <20181102183246.r5xxwsic2mxwihsi@localhost>
Message-ID: <8fe7491c-74de-3192-c583-37cd1583cfd6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 02/11/18 18:32, Olof Johansson wrote:
> On Thu, Oct 18, 2018 at 05:17:33PM +0800, Chunyan Zhang wrote:
>> Hi Arnd,
>>
>> For 4.20-rc1 there's one patch only for sprd devicetree, please pull from my git tree:
>>
>> https://github.com/lyrazhang/linux.git m-v4.19-rc1
>>
>> Please let me know if there's some problem.
>>
>> Thanks,
>> Chunyan
>>
>> ----------------------------------------------------------------
>>
>> Suzuki K Poulose (1):
>>    arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
>>      ports
>>
>>   arch/arm64/boot/dts/sprd/sc9836.dtsi |  78 +++++++------
>>   arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++++++-----------------
>>   2 files changed, 151 insertions(+), 142 deletions(-)
> 
> Hi,
> 
> This came in right before the merge window so it wasn't included since
> it's more of a cleanup.

A minor correction. This is not really a cleanup, but upgrading the
bindings to the new DTS bindings for Coresight. The driver will now
complain about old bindings, which could be hit on these boards. Not
the end of the world, it could be queued for 4.21.

Cheers
Suzuki
