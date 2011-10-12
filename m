From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 12 Oct 2011 11:14:01 +0200
Subject: Update: ARM Sub-Architecture Maintainers workshop at Kernel Summit
	2011
In-Reply-To: <4E81CEB8.4090908@compulab.co.il>
References: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
	<4E81CEB8.4090908@compulab.co.il>
Message-ID: <4E955A59.4090705@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/11 16:25, Igor Grinberg wrote:
> On 08/30/11 09:00, Grant Likely wrote:
>>
>> Agenda proposals (Thanks to Nicolas and Olof):
>> - DT bindings for GPIO and pin mux
>> - the pin mux subsystem from linusw (especially if it is still RFC by
>>  then)
>> - progress with the single zImage work
>> - presentation/status of the DMA and memory management work wrt CMA
>>  (some SOC specific hacks should go away once this is available)
>> - DT porting progress
>> - boot architecture status
>> - Report from Arnd on experiences from first arm-soc merge window
>>   - what worked well and where's room for improvement?
>>   - Any particular SoC workflow that should be tuned to make his life easier?
>>   - Where are the gaps where he needs help right now?
>>   - How did it work out for the SoC maintainers?
>>
>> Still accepting more proposals.  Send me the topics you are burning to discuss.
> 
> One of the LPC2011's bottom lines was:
> "We need more people involved in ARM maintainership to help
> the sub-architecture maintainers do a better job on
> review/consolidation/generalization/etc. of the code."
> 
> Despite the major goal of the DT to reduce the SoC and
> board specific code to absolute minimum, there will still be cases
> (e.g. discrete power management circuitry) when there is no
> appropriate DT solution available and the board file
> is a necessity. Also there are already many boards that will remain
> and will not be converted to DT.
> 
> Bringing all the above together, I'd like to propose a new "job"
> for maintaining board specific code on a cross-platform basis.
> 
> Pros:
> 1) There might (I have not checked this, but I'm sure there is) be
> code in the existing board files (that are not likely to go away
> at least in a couple of years) that can be consolidated and
> may be even in a cross-platform manner.
> 2) Lower the work load from SoC maintainers (that don't have enough
> time to care much about the board specific changes).
> 3) Some more eyes to review the newly submitted code.
> 
> Cons:
> 1) Resulting overhead for the code to go upstream.
> 2) Possible addition of merge conflicts.
> 
> 
> I'd like to hear, what do you think of the above proposal?

Any thoughts? Yes? No? Why? WTF?

 

-- 
Regards,
Igor.
