From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 7 Feb 2018 16:53:02 +0000
Subject: [PATCH v2 05/20] arm64: capabilities: Add flags to handle the
 conflicts on late CPU
In-Reply-To: <7221b67c-6581-93bd-ebb3-7e48736ecb02@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-6-suzuki.poulose@arm.com>
 <20180207103804.GV5862@e103592.cambridge.arm.com>
 <7221b67c-6581-93bd-ebb3-7e48736ecb02@arm.com>
Message-ID: <ab56a18c-a022-a6f5-05f7-b35b09ba74f6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/18 11:31, Robin Murphy wrote:
> On 07/02/18 10:38, Dave Martin wrote:
>> On Wed, Jan 31, 2018 at 06:27:52PM +0000, Suzuki K Poulose wrote:

...

>>> Case (b) is not permitted for errata work arounds which requires some work
>>> around, which cannot be delayed. And we ignore (b) for features. Here, yet
>>
>> Nit, maybe:
>>
>> "Case (b) is not permitted for any errata workaround that cannot be
>> activated if the kernel has finished booting and has not already enabled
>> it."
> 
> Nit^2: I think it would suffice to say "...that cannot be activated after the kernel has finished booting." - since we don't really have the concept of *de*activating workarounds, it is already implicit in that statement that the one in question wasn't activated *before* the kernel finished booting.

Robin, Dave,

I have updated the comments accordingly.

Thanks a lot for the review

Suzuki
