From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 3 Jan 2018 21:17:26 -0800
Subject: [PATCH v3 00/20] arm64: Unmap the kernel whilst running in
 userspace (KPTI)
In-Reply-To: <20171211175901.vbw7fpeijpqbp263@armageddon.cambridge.arm.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
 <20171211175901.vbw7fpeijpqbp263@armageddon.cambridge.arm.com>
Message-ID: <6fa84768-7431-22d2-4930-35b0b65ae86f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2017 09:59 AM, Catalin Marinas wrote:
> On Wed, Dec 06, 2017 at 12:35:19PM +0000, Will Deacon wrote:
>> Patches are also pushed here:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git kpti
>>
>> Feedback and testing welcome. At this point, I'd like to start thinking
>> about getting this merged for 4.16.
> 
> For the record, the fixed up version was pushed by Will here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git kpti
> 
> and I queued it for 4.16 in the arm64 for-next/core branch (same tree as
> above).

Greg proposed the x86/KPTI patches for the stable-4.9.75 queue, is there
a plan to get the ARM64/KPTI patches backported towards stable trees as
well?

Thanks!
-- 
Florian
