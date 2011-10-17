From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 17 Oct 2011 19:36:00 +0200
Subject: Update: ARM Sub-Architecture Maintainers workshop at Kernel	Summit
	2011
In-Reply-To: <20111012091900.GA13134@arm.com>
References: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>	<4E81CEB8.4090908@compulab.co.il>
	<4E955A59.4090705@compulab.co.il> <20111012091900.GA13134@arm.com>
Message-ID: <4E9C6780.1070003@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 10/12/11 11:19, Catalin Marinas wrote:
> On Wed, Oct 12, 2011 at 10:14:01AM +0100, Igor Grinberg wrote:
>>> One of the LPC2011's bottom lines was:
>>> "We need more people involved in ARM maintainership to help
>>> the sub-architecture maintainers do a better job on
>>> review/consolidation/generalization/etc. of the code."
>>>
>>> Despite the major goal of the DT to reduce the SoC and
>>> board specific code to absolute minimum, there will still be cases
>>> (e.g. discrete power management circuitry) when there is no
>>> appropriate DT solution available and the board file
>>> is a necessity. Also there are already many boards that will remain
>>> and will not be converted to DT.
>>>
>>> Bringing all the above together, I'd like to propose a new "job"
>>> for maintaining board specific code on a cross-platform basis.
>>>
>>> Pros:
>>> 1) There might (I have not checked this, but I'm sure there is) be
>>> code in the existing board files (that are not likely to go away
>>> at least in a couple of years) that can be consolidated and
>>> may be even in a cross-platform manner.
>>> 2) Lower the work load from SoC maintainers (that don't have enough
>>> time to care much about the board specific changes).
>>> 3) Some more eyes to review the newly submitted code.
>>>
>>> Cons:
>>> 1) Resulting overhead for the code to go upstream.
>>> 2) Possible addition of merge conflicts.
>>>
>>>
>>> I'd like to hear, what do you think of the above proposal?
>>
>> Any thoughts? Yes? No? Why? WTF?
> 
> Isn't this what the sub-architecture group (Arnd etc.) already started
> doing? Or I missed something in your proposal.

I think you did miss something, my proposal is for board specific
stuff, not SoC specific. It is another level of abstraction, which
is not always seen.
Anyway, please, see my answer to Nico.

Thanks 

-- 
Regards,
Igor.
