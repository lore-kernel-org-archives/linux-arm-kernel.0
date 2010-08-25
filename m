From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 25 Aug 2010 16:26:34 -0700
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <20100825155814.25c783c7.akpm@linux-foundation.org>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
Message-ID: <1282778794.13797.15.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-08-25 at 15:58 -0700, Andrew Morton wrote:
> That would be good.  Although I expect that the allocation would need
> to be 100% rock-solid reliable, otherwise the end user has a
> non-functioning device.  Could generic core VM provide the required
> level
> of service?
> 
> Anyway, these patches are going to be hard to merge but not
> impossible.
> Keep going.  Part of the problem is cultural, really: the consumers of
> this interface are weird dinky little devices which the core MM guys
> tend not to work with a lot, and it adds code which they wouldn't use.
> 
> I agree that having two "contiguous memory allocators" floating about
> on the list is distressing.  Are we really all 100% diligently certain
> that there is no commonality here with Zach's work?

There is some commonality with Zach's work, but Zach should be following
all of this development .. So presumably he has no issues with Michal's
changes. I think Zach's solution has a similar direction to this.

If Michal is active (he seems more so than Zach), and follows community
comments (including Zach's , but I haven't seen any) then we can defer
to that solution ..

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
