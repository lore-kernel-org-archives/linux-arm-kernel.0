From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Thu, 19 May 2011 16:25:50 +0100 (BST)
Subject: Question on ARM inline assembly - stackframes, sp/fp usage,
	__naked
In-Reply-To: <20110519094753.GB2431@arm.com>
References: <alpine.DEB.2.00.1105181505080.2374@localhost6.localdomain6>
	<20110518174531.GA28300@arm.com>
	<alpine.DEB.2.00.1105190858320.2374@localhost6.localdomain6>
	<20110519094753.GB2431@arm.com>
Message-ID: <alpine.DEB.2.00.1105191547480.28998@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 May 2011, Dave Martin wrote:

> On Thu, May 19, 2011 at 09:46:30AM +0100, Frank Hofmann wrote:
>>
>>
>> On Wed, 18 May 2011, Dave Martin wrote:
>>
>>> On Wed, May 18, 2011 at 04:25:15PM +0100, Frank Hofmann wrote:
>>>> Hi,
[ ... ]
>
> As I said, it may work, today.  It just feels more complex and
> failure-prone, because it reiles on details of the compiler behaviour.
> If doing this provided a real benefit, like better maintainability or
> performance, then it would be worth trying.  But I feel we don't get
> any real advantages in this case.
>
> That's just my opinion, but I know from experience how hard it is to get
> compiler guys on your side when this kind of hack goes wrong...

That bit of _experience_ is what I'm still building up, on ARM ... a great 
thanks to you, M?ns and Mikael for providing that.

GCC is capricious wrt. to inline assembly, I understand now.

[ ... ]
> For totally arch-specific parts like saving/restoring the processor
> state, at least some assembler is unavoidable...

I'll keep the two files (one for the pure assembly, one for C only 
parts) for now.

Best wishes,
FrankH.

>
> Cheers
> ---Dave
>
>
