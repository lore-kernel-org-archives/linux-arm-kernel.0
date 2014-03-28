From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Fri, 28 Mar 2014 23:43:47 +0200
Subject: [GIT PULL] ARM: kprobes: big-endian support
In-Reply-To: <20140328182256.GO7528@n2100.arm.linux.org.uk>
References: <52D3D784.2000600@linaro.org> <53053769.5090100@linaro.org>
 <5332AB5A.90109@linaro.org> <20140328112841.GF7528@n2100.arm.linux.org.uk>
 <5335BBB1.60402@linaro.org> <20140328182256.GO7528@n2100.arm.linux.org.uk>
Message-ID: <5335ED13.30805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2014 08:22 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 28, 2014 at 08:13:05PM +0200, Taras Kondratiuk wrote:
>> On 03/28/2014 01:28 PM, Russell King - ARM Linux wrote:
>>> On Wed, Mar 26, 2014 at 12:26:34PM +0200, Taras Kondratiuk wrote:
>>>> On 02/20/2014 12:59 AM, Taras Kondratiuk wrote:
>>>>
>>>> Hi Russell,
>>>>
>>>> Is there any issue with this pull request?
>>>> Should I do something to get it pulled?
>>>
>>> There's nothing wrong, apart from me being far too busy hacking on really
>>> crap code to care about reading much email - which means that lots of
>>> email simply just gets buried and lost.
>>>
>>> There is now a problem with this pull - it conflicts very badly with Dave
>>> Long's uprobes code, which I've already pulled, so much so that I'm not
>>> happy to do the conflict resolution since I know nothing about this code,
>>> and it's a feature I don't make any use of.
>>
>> I've rebased it onto your for-next branch. Kprobes are functional
>> in LE and BE. I'll send an updated pull request after verifying uprobes.
> 
> That's not going to work.  for-next is an unstable branch - all the
> merge commits there get regenerated on a fairly regular basis.
> 
> A better solution would be to base your patches on top of Dave Long's
> changes, which can be found at
> 
>  git://git.linaro.org/people/dave.long/linux uprobes-v7
> 
> and should have an ID of c7edc9e326d5.

Ok I'll base on Dave's branch.

-- 
Taras Kondratiuk
