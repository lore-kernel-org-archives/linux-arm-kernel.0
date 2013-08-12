From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Mon, 12 Aug 2013 09:54:25 +0100
Subject: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
In-Reply-To: <5203BE15.2040506@arm.com>
References: <52012049.7060605@arm.com>	<5203AE82.5080203@arm.com>
 <CAL_JsqKwHtW4qBkXq=FmOmCrN35Oe+HuDbG=u9BwK8Aas2Paww@mail.gmail.com>
 <5203BE15.2040506@arm.com>
Message-ID: <5208A2C1.7080503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/13 16:49, Sudeep KarkadaNagesha wrote:
> On 08/08/13 16:27, Rob Herring wrote:
>> On Thu, Aug 8, 2013 at 9:43 AM, Sudeep KarkadaNagesha
>> <Sudeep.KarkadaNagesha@arm.com> wrote:
>>> Hi Rob,
>>>
>>> On 06/08/13 17:11, Sudeep KarkadaNagesha wrote:
>>>> Hi Rob,
>>>>
>>>> The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:
>>>>
>>>>   Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://linux-arm.org/linux-skn.git cpu_ofnode_dt
>>>>
>>>> for you to fetch changes up to d7b5133478afd9e66a338d3125bc37b9a250ef66:
>>>>
>>>>   of/device: add helper to get cpu device node from logical cpu index
>>>> (2013-08-06 16:37:15 +0100)
>>>>
>>>
>>> I was not sure whom to send pull request(you or Grant).
>>> This needs to be pulled in and present in linux-next before I can send
>>> the updates in SoC and cpufreq which depends on this.
>>
>> With necessary acks, you don't need send these to 3 maintainers. I
>> would suggest you send the whole series to cpufreq maintainers to
>> merge rather than have them try to manage 2 dependent branches.
>>
>> Also, something landing in linux-next has no bearing on the process.
>> If you do have dependent branches in another tree, then you need to
>> insure with that maintainer that the branch is stable and inform the
>> 2nd maintainer of the dependency on the branch.
>>
> 
> Thanks Rob for clarifying.
> 
> Hi Rafael,
> 
> The complete series[1] was reviewed and acknowledged by appropriate
> maintainers.
> 
> Since most of the changes are CPUFreq clean-ups, would you take the
> complete series through your tree ?
> 
> On which branch(bleeding-edge or linux-next) on [2] do I need to base my
> pull request ?
Hi Rafael,

Can you please let which know which branch do you prefer to base the my
request on ?

Regards,
Sudeep

> 
> [1]
> http://archive.arm.linux.org.uk/lurker/message/20130722.113211.b5e3bc2a.fr.html
> 
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> 
