From: s-anna@ti.com (Suman Anna)
Date: Fri, 21 Jun 2013 10:24:44 -0500
Subject: linux-next: manual merge of the arm-soc tree with the mailbox tree
In-Reply-To: <201306210936.09593.arnd@arndb.de>
References: <20130621162656.bb94e0fa8b6813781b804a73@canb.auug.org.au>
 <CAOesGMjszju75jo6Ej6C=0-rfdPLuEj0mwmU1zYvFvYw1dyQCA@mail.gmail.com>
 <20130621071239.GM5523@atomide.com> <201306210936.09593.arnd@arndb.de>
Message-ID: <51C4703C.10206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

On 06/21/2013 02:36 AM, Arnd Bergmann wrote:
> On Friday 21 June 2013, Tony Lindgren wrote:
>>> I wonder if this mess is caused by the fact that I did the revert
>>> instead of rebuilding our for-next and dropping the merge in the first
>>> place.
>>>
>>> I'll rebuild our for-next (or maybe Arnd will beat me to it) before
>>> next linux-next build, i.e. Sunday night my time.
>>
>> Could be, especially if some of the commits are the same in the reverted
>> branch and newly merged branch as git might think that some merges have
>> been already resolved the right way earlier.

Yes, please drop the particular mailbox branch that you were picking
into linux-next. It was the previous framework which was dropped at the
last minute during the 3.10 merge window in favor of new one still under
its final development steps, so we will not be using any commits from
that branch.  Sorry for the trouble on this one. The branch that Arnd
took has some of the OMAP patches reworked in preparation for the
newer one.

> 
> I already rebuilt the arm-soc tree before Stephen started with today's
> linux-next, so I think the conflict is elsewhere.
> 
> It's probably best if Suman Anna rebases the mailbox tree on top of
> the omap mailbox branch that I took.
> 

I will rebase the mailbox tree once we have the new patches from Jassi
finalized.

regards
Suman
