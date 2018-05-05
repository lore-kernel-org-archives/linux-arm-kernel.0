From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Sat, 5 May 2018 10:49:53 +0100
Subject: [PATCH] [stable] arm64: Add work around for Arm Cortex-A55
 Erratum 1024718
In-Reply-To: <20180504221508.GD20328@kroah.com>
References: <1525170364-21032-1-git-send-email-suzuki.poulose@arm.com>
 <20180504221508.GD20328@kroah.com>
Message-ID: <39eef51c-3b6b-3c32-c6ee-15bae1d4b13b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 05/04/2018 11:15 PM, Greg KH wrote:
> On Tue, May 01, 2018 at 11:26:04AM +0100, Suzuki K Poulose wrote:
>> commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream
>>

...

>>
>> Note: The upstream commit is on top of a reworked capability
>> infrastructure for arm64 heterogeneous systems, which allows
>> handling this later in the boot process. This backport
>> is based on the original version of the patch [0]. Folded the 3
>> patches into this single commit, removing the unncessary bits.
>>
>> [0] https://lkml.kernel.org/r/20180116102323.3470-1-suzuki.poulose at arm.com
>>
>> Cc: stable at vger.kernel.org # v4.3 to v4.16
> 
> This only would apply to the 4.16.y tree.  Can you provide working
> backports to 4.14.y, 4.9.y, and 4.4.y so I can queue them up there as
> well?


Sure, I will send them soon.

Cheers
Suzuki
