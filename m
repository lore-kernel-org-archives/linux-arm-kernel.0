From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 4 Jan 2018 10:23:40 -0800
Subject: [PATCH v3 00/20] arm64: Unmap the kernel whilst running in
 userspace (KPTI)
In-Reply-To: <20180104065018.GA22792@kroah.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
 <20171211175901.vbw7fpeijpqbp263@armageddon.cambridge.arm.com>
 <6fa84768-7431-22d2-4930-35b0b65ae86f@gmail.com>
 <20180104065018.GA22792@kroah.com>
Message-ID: <092a51ec-f856-2b51-5d47-8acbdc671031@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2018 10:50 PM, Greg Kroah-Hartman wrote:
> On Wed, Jan 03, 2018 at 09:17:26PM -0800, Florian Fainelli wrote:
>> On 12/11/2017 09:59 AM, Catalin Marinas wrote:
>>> On Wed, Dec 06, 2017 at 12:35:19PM +0000, Will Deacon wrote:
>>>> Patches are also pushed here:
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git kpti
>>>>
>>>> Feedback and testing welcome. At this point, I'd like to start thinking
>>>> about getting this merged for 4.16.
>>>
>>> For the record, the fixed up version was pushed by Will here:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git kpti
>>>
>>> and I queued it for 4.16 in the arm64 for-next/core branch (same tree as
>>> above).
>>
>> Greg proposed the x86/KPTI patches for the stable-4.9.75 queue, is there
>> a plan to get the ARM64/KPTI patches backported towards stable trees as
>> well?
> 
> Stable tree patches have to get into Linus's tree first before I can do
> anything :)
> 
> Anyway, once that happens, yes, there is a plan, but it's a bit
> "different", and I'll talk about it once these are merged.

Great, thanks! Bonus question, if someone is using any of the affected
devices in AArch32, should we be expecting to see ARM/Linux changes as
well, that is, is there a plan to come up with a kpti implementation for
ARM?
-- 
Florian
