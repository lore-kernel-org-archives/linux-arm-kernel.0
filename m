From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 17 Oct 2011 19:31:13 +0200
Subject: Update: ARM Sub-Architecture Maintainers workshop at Kernel Summit
	2011
In-Reply-To: <alpine.LFD.2.02.1110121103090.17040@xanadu.home>
References: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
	<4E81CEB8.4090908@compulab.co.il> <4E955A59.4090705@compulab.co.il>
	<alpine.LFD.2.02.1110121103090.17040@xanadu.home>
Message-ID: <4E9C6661.70402@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/11 17:33, Nicolas Pitre wrote:
> On Wed, 12 Oct 2011, Igor Grinberg wrote:
> 
>> On 09/27/11 16:25, Igor Grinberg wrote:
>>> On 08/30/11 09:00, Grant Likely wrote:
>>>> Still accepting more proposals.  Send me the topics you are burning to discuss.
>>>
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
> Well...  Please see http://lwn.net/Articles/443510/.
> 
> Since then,  ARnd Bergmann has led the arm-soc repository maintenance 
> effort as you might have noticed.  Other cleanup/consolidation projects 
> are also progressing in parallel.

Yes, of course I've noticed (how can someone to not notice?).

> 
> Obviously, as always, we would always benefit from more reviewers and 
> more people in maintainership roles.  The general situation has improved 
> since a couple months ago, but any additional suggestions you might have 
> will always be welcome.

Yes, the situation did improve, that is correct.

Currently, SoC maintainers have a separate branch of board specific
patches and it is kind of a burden that they live with and push it
to Arnd.
What I'm trying to propose here is another level of maintainership.
Which would accumulate board specific stuff (not SoC specific) and
push it to Arnd directly with no need to involve SoC maintainers
(may be only for Acks on SoC stuff).
Despite all the efforts to move to DT, there is still much work
must be done and IMO the board files aren't going to disappear in
the near future (say 2 years?). Meanwhile, my proposition can
lower the work load from SoC maintainers.

There is a possibility that my proposal will not serve well,
or may be it will?

Before making any decision, I want to make sure you understand
what is that I'm proposing here.

-- 
Regards,
Igor.
