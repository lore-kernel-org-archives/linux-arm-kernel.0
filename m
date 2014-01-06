From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 6 Jan 2014 10:44:27 +0100
Subject: linux-next: manual merge of the renesas tree with the arm-soc tree
In-Reply-To: <CAOesGMgi3COtsr+-9B3Tt350gwBs0Qm0AjatjLWCWTeUkAP5og@mail.gmail.com>
References: <20131216104738.6f845aabd0e3b609ed9ca170@canb.auug.org.au>	<52AECF56.8020508@atmel.com>
 <CAOesGMgi3COtsr+-9B3Tt350gwBs0Qm0AjatjLWCWTeUkAP5og@mail.gmail.com>
Message-ID: <52CA7AFB.9010208@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2014 06:11, Olof Johansson :
> On Mon, Dec 16, 2013 at 2:00 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>> On 16/12/2013 00:47, Stephen Rothwell :
>>> Hi Simon,
>>>
>>> Today's linux-next merge of the renesas tree got a conflict in
>>> drivers/clk/Makefile between commit 0ad6125b1579 ("clk: at91: add PMC
>>> base support") from the arm-soc tree and commit 10cdfe9f327a ("clk:
>>> shmobile: Add R-Car Gen2 clocks support") from the renesas tree.
>>>
>>> I fixed it up (see below) and can carry the fix as necessary (no action
>>> is required).
>>
>> Fine for me.
> 
> Simon, Nicolas,
> 
> <mini-rant>
> 
> While a very minor issue, this should have been altogether avoided
> with a little more attention when applying patches. The Makefile is
> sorted, and you've appended new lines to the end instead of in the
> place they're supposed to go. Sure, others have done the same mistake
> in a few places but that doesn't mean we shouldn't try to keep it
> sorted.
> 
> The very reason _to_ sort a Makefile is to avoid these needless
> add-add conflicts when two people append to the same unsorted list.
> 
> Now I can't resolve it properly and move the entries when I do the
> same merge (and get the same conflict), because that will cause a
> third conflict for Stephen, and he's about to return from vacation and
> is going to cuss at us if we cause too many new conflicts in one day.
> :)
> 
> </mini-rant>
> 
> So, best choice is to keep the unsortedness now, and have Mike resort
> his Makefile for us at the end of the merge window. And keep a little
> closer eye on Makefile and Kconfig additions in the future. :)

Totally agree in keeping a Makefile sorted, when it is already sorted.
What I recall having thought when I had seen this Makefile is: well this
one must be of the "append your changes to the end" type...

Anyway be sure that I will pay attention to this.

Bye,
-- 
Nicolas Ferre
