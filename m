From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 26 Apr 2016 15:56:04 +0100
Subject: [PATCH v5 0/5] arm64: Fix behavior of maxcpus=n
In-Reply-To: <20160426145046.GB1793@arm.com>
References: <1461682140-7131-1-git-send-email-suzuki.poulose@arm.com>
 <20160426145046.GB1793@arm.com>
Message-ID: <571F8184.7000400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/16 15:50, Will Deacon wrote:

>> Changes since V4:
>>   - Address Catalin's comments
>>   - Rebased to aarch64 for-next/core
>>   - Add Reviewed/Acked bys.
>
> I merged this yesterday onto for-next/core. Please can you check that
> I fixed everything up that you expected?

Just did a git diff and it looks alright. I pulled it yesterday before the push and hence missed
it, may be should have done dsb() today before sending ;-)

Thanks
Suzuki
