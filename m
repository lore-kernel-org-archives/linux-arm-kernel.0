From: bgat@billgatliff.com (Bill Gatliff)
Date: Wed, 07 Oct 2009 09:44:27 -0500
Subject: i.MX31 kernel panic and irq
In-Reply-To: <20091007132051.GB11371@n2100.arm.linux.org.uk>
References: <87077C4F48609F4392621D9F99DDE20901202E0E@tesla.star.galaxy.io>
	<4ACB659E.3000206@billgatliff.com>
	<20091007132051.GB11371@n2100.arm.linux.org.uk>
Message-ID: <4ACCA94B.60708@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Tue, Oct 06, 2009 at 10:43:26AM -0500, Bill Gatliff wrote:
>   
>> The OOPS messages suggest that the machine has run off into stuff that  
>> isn't code, which would be consistent with the stack pointer getting  
>> blown out of the stack memory.
>>     
>
> I don't follow your line of reasoning.

I protected myself by saying I was "speculating".  :)

I think some of the other dumps I saw from him were less clear as to the 
problem, which combined with his descriptions of how he was triggering 
the event made me think about stack corruption as a meta-problem.

Stack corruption could result in register value corruption, for sure.  
And the fact that his board doesn't fail in the same way each time makes 
me look more at the pattern of OOPS dumps rather than the individual ones.

But you've definitely looked at this dump in more detail than I did.  So 
I could be speculating in the wrong direction altogether.  I was just 
trying to distract him until you solved the problem.  :)


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
