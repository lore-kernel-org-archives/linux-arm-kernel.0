From: b.hutchman@gmail.com (Brian Hutchinson)
Date: Wed, 7 Oct 2009 21:21:02 -0400
Subject: i.MX31 kernel panic and irq
In-Reply-To: <4ACCA94B.60708@billgatliff.com>
References: <87077C4F48609F4392621D9F99DDE20901202E0E@tesla.star.galaxy.io>
	<4ACB659E.3000206@billgatliff.com>
	<20091007132051.GB11371@n2100.arm.linux.org.uk>
	<4ACCA94B.60708@billgatliff.com>
Message-ID: <3d1967ab0910071821p2c67d6b2o6f38b2e5b085534e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 7, 2009 at 10:44 AM, Bill Gatliff <bgat@billgatliff.com> wrote:

> Russell King - ARM Linux wrote:
>
>> On Tue, Oct 06, 2009 at 10:43:26AM -0500, Bill Gatliff wrote:
>>
>>
>>> The OOPS messages suggest that the machine has run off into stuff that
>>>  isn't code, which would be consistent with the stack pointer getting  blown
>>> out of the stack memory.
>>>
>>>
>>
>> I don't follow your line of reasoning.
>>
>
> I protected myself by saying I was "speculating".  :)
>
> I think some of the other dumps I saw from him were less clear as to the
> problem, which combined with his descriptions of how he was triggering the
> event made me think about stack corruption as a meta-problem.
>
> Stack corruption could result in register value corruption, for sure.  And
> the fact that his board doesn't fail in the same way each time makes me look
> more at the pattern of OOPS dumps rather than the individual ones.
>
> But you've definitely looked at this dump in more detail than I did.  So I
> could be speculating in the wrong direction altogether.  I was just trying
> to distract him until you solved the problem.  :)
>
> Ha! Bill gives the Jedi wave "this isn't the bug you've been looking for".
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091007/fcf670ba/attachment.htm>
