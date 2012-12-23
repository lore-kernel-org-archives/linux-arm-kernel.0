From: will.deacon@arm.com (Will Deacon)
Date: Sun, 23 Dec 2012 11:11:18 +0000
Subject: [RFC PATCH 0/6] ARM: mm: HugeTLB + THP support.
In-Reply-To: <50D4671F.1010003@free-electrons.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
 <50D4671F.1010003@free-electrons.com>
Message-ID: <20121223111118.GC16237@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 01:41:51PM +0000, Gregory CLEMENT wrote:
> On 10/18/2012 06:15 PM, Steve Capper wrote:
> > Hello,
> Hi Steve,

Hi Gregory,

> I resurrected this old thread to have some news about this subject.
> We are interested to get this support for the Armada 370/XP based boards.
> 
> I am surprised that there wasn't any feedback on this series. We are
> willing to help this feature being merge in the kernel.
> 
> Testing your series on the board we have could help you?

Whilst testing is always welcome, the thing this code *really* needs is some
proper review, especially for the implementation for 3-level page tables. We
tested pretty extensively on v6, v7 and v7+lpae platforms ourselves but, of
course, if you do uncover an issue then please shout.

Will
