From: olof@lixom.net (Olof Johansson)
Date: Sun, 11 Aug 2013 15:14:26 -0700
Subject: [RFC PATCH] ARM: dma: default ZONE_DMA to y if ARM_LPAE
In-Reply-To: <20130811220541.GZ23006@n2100.arm.linux.org.uk>
References: <1374843951-1615-1-git-send-email-will.deacon@arm.com>
 <20130811215112.GB26757@quad.lixom.net>
 <20130811220541.GZ23006@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMgvU4Vxg1vwnvjUp3fEHbWDYc1mKTvCyaE4zQOfMr_2sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 3:05 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> No.  As I keep telling people, go look at my dma-mask patches and stop
> papering over this problem.

Ah, yes, I'm going through email backlog. The DMA mask series will
definitely cover this in a better way.

This is a minimal patch that could be suitable for -stable backport.
If we care about that -- I'm sure people can just amend their configs
where needed.


-Olof
