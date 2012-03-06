From: robherring2@gmail.com (Rob Herring)
Date: Mon, 05 Mar 2012 20:44:07 -0600
Subject: [PATCH] ARM: remove ixp2000 platform
In-Reply-To: <alpine.LFD.2.02.1203052035170.31242@xanadu.home>
References: <1330450426-14639-1-git-send-email-robherring2@gmail.com>
 <201202281945.39419.arnd@arndb.de>
 <alpine.LFD.2.02.1203052035170.31242@xanadu.home>
Message-ID: <4F5579F7.7040603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2012 07:41 PM, Nicolas Pitre wrote:
> On Tue, 28 Feb 2012, Arnd Bergmann wrote:
> 
>> On Tuesday 28 February 2012, Rob Herring wrote:
>>> ixp2000 has no commits other than tree-wide changes or refactoring since
>>> 2006. No maintainer is listed for ixp2000 either.
>>
>> I have this in my copy of the MAINTAINERS file:
>>
>> ARM/INTEL IXP2000 ARM ARCHITECTURE
>> M:      Lennert Buytenhek <kernel@wantstofly.org>
>> L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>> S:      Maintained
>>
>> It's missing an F: line, otherwise it suggests that the platform is still
>> maintained by Lennert and it certainly builds just fine. Unfortunately he
>> seems to have fallen off the edge of the planet at the end of last year.
> 
> FYI, here's a snippet of a conversation I just had with Lennert on IRC 
> today:
> 
> 13:05 < nico> do you still care about ixp2000?
> 13:22 < lennert> not really, no
> 13:58 < nico> do you think we could remove it from the kernel tree?
> 14:01 < lennert> go for it, and remove ixp23xx too while you're at it

So, can we do this for 3.4 or should wait for 3.5?

Rob
