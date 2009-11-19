From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Thu, 19 Nov 2009 19:19:03 +0100
Subject: MX3 SDMA?
In-Reply-To: <20091119172708.GN14091@buzzloop.caiaq.de>
References: <20091119172708.GN14091@buzzloop.caiaq.de>
Message-ID: <59b21cf20911191019v4b030b75qf383b3832607768a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

2009/11/19 Daniel Mack <daniel@caiaq.de>:
> Hi,
>
> I wonder whether anyone is currently working on porting the SDMA engie
> from Freescale's BSPs to mainline?
>
> If not, what would be a sane approach to start that? From what I've
> seen, there is support specifically for the SoC's on-chip peripherals
> which could be implemented with an API similar to the clock framework
> (ie, matching via device names).
>
> As this engine features an own RISC processor and is a huge monster, I
> would assume starting with supporting a subset of features would make
> sense.
>
> Plans, ideas?

The last attempt was made by someone in September but I didn't see any
result at all:
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-September/000886.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-September/001024.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/001806.html


Regards, Magnus
