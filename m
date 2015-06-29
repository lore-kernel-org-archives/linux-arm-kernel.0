From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 29 Jun 2015 18:11:13 +0100
Subject: [PATCH] arm64: KVM: Enable minimalistic support for Thunder
In-Reply-To: <AED13EAB-D578-451F-AC35-A45A21816076@caviumnetworks.com>
References: <1435348284-32132-1-git-send-email-tchalamarla@caviumnetworks.com>
 <55910794.6000107@arm.com>
 <AED13EAB-D578-451F-AC35-A45A21816076@caviumnetworks.com>
Message-ID: <55917C31.4060107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/06/15 18:06, Chalamarla, Tirumalesh wrote:
> 
>> On Jun 29, 2015, at 1:53 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>> On 26/06/15 20:51, Tirumalesh Chalamarla wrote:
>>> In order to allow KVM to run on Thunder implementations, add the
>>> minimal support required.
>>>
>>> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
>>
>> CCing the KVM/ARM maintainers should be the first course of action.
>>
> thanks. 
> 
>> Also, you may want to try Suzuki's patch instead:
>>
>> http://www.spinics.net/lists/kvm/msg117703.html
>>
> will try with this.
> 
>> Constantly adding new CPUs without providing any insight as to how they
>> should be emulated only brings churn, and not much benefit.
>>
> we are not planning(at this point) to emulate Thunder with QEMU/others.   

Fair enough. If cross-cpu VM migration is none of your concern, then
Suzuki's patch should be enough.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
