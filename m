From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 15 May 2018 09:25:20 +0100
Subject: [GIT PULL] arm64: hisi: SoC driver updates for v4.18
In-Reply-To: <20180514201859.fihe7n5jmvm5h6k3@localhost>
References: <5AF5ABC1.60009@hisilicon.com>
 <20180514201859.fihe7n5jmvm5h6k3@localhost>
Message-ID: <5AFA9970.3050008@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 2018/5/14 21:18, Olof Johansson wrote:
> On Fri, May 11, 2018 at 03:42:09PM +0100, Wei Xu wrote:
>> Hi Arnd, Hi Olof,
>>
>> Please help to pull the following changes.
>> Sorry for the inconvenience, because it depends on this patch [1]
>> which was merged in the rc3, I rebased the pull on rc3.
>> Thanks!
>>
>> [1] HISI LPC: Add Kconfig MFD_CORE dependency
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/bus?h=v4.17-rc3&id=4b313ca7b661ab8782f3dcb4a8996632a470b4da
>>
>> Best Regards,
>> Wei
>>
>> ---
>>
>> The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:
>>
>>   Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/hisilicon/linux-hisi.git tags/hisi-drivers-for-4.18
>>
>> for you to fetch changes up to adf3457b4ce6940885be3e5ee832c6949fba4166:
>>
>>   HISI LPC: Add ACPI UART support (2018-05-10 17:45:52 +0100)
>>
>> ----------------------------------------------------------------
>> ARM64: hisi: SoC driver updates for 4.18
>>
>> - Update hisi LPC bus driver to use the platform driver APIs
>>   other than the MFD APIs to support connected device like UART
> 
> Merged, thanks.
> 
> Same thing here as with the DT branch though -- if you look at a lot
> of other patches under drivers/bus, nearly all of them use "bus: <...>"
> as prefix, so please move over to using that for yours as well on future
> patches/pull requests.
> 

Sorry, I will take care these kind of things in the future.
Thanks!

Best Regards,
Wei

> 
> 
> -Olof
> 
> .
> 
