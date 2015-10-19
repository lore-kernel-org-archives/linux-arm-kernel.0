From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 18:43:51 +0100
Subject: [UPDATED] [PATCHv4 00/12] arm64: 16K translation granule support
In-Reply-To: <20151019173040.GF11226@e104818-lin.cambridge.arm.com>
References: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
 <20151019173040.GF11226@e104818-lin.cambridge.arm.com>
Message-ID: <56252BD7.6030209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/15 18:30, Catalin Marinas wrote:
> On Mon, Oct 19, 2015 at 02:19:26PM +0100, Suzuki K. Poulose wrote:
>> Ard Biesheuvel (1):
>>    arm64: Add page size to the kernel image header
>>
>> Mark Rutland (1):
>>    arm64: Simplify NR_FIX_BTMAPS calculation
>>
>> Suzuki K. Poulose (10):
>
> Patches applied. I'm not fully convinced about the 36-bit VA yet, it

Thanks.

> increases the validation space and I think with little benefit (to be
> seen on real hardware). I may make it depend on EXPERT.
>

Makes sense. I am fine with that.

Suzuki
