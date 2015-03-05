From: lsanfil@marvell.com (Lino Sanfilippo)
Date: Thu, 5 Mar 2015 14:20:43 +0100
Subject: [RFC PATCH 0/1] Wrong structure alignment due to compiler
 attribute "section"
In-Reply-To: <20150305122606.GC3612@e103592.cambridge.arm.com>
References: <1425290502-2322-1-git-send-email-lsanfil@marvell.com>
 <20150303144130.GB5177@e103592.cambridge.arm.com>
 <54F6EF32.7080306@marvell.com>
 <20150304143527.GA5653@e103592.cambridge.arm.com>
 <54F732DA.2050004@marvell.com>
 <20150305122606.GC3612@e103592.cambridge.arm.com>
Message-ID: <54F8582B.80703@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.03.2015 13:26, Dave Martin wrote:

>>
>> So this is indeed a compiler bug, right?
>
> It certainly looks like the compiler is causing the issue somehow.
>
> Whether this is a bug, a bug-like feature, a configuration issue,
> or a combination of these is not clear.
>
> If you know where to find the toolchain source, it might be worth
> taking a look.

The toolchain can be found here:
http://www.plugcomputer.org/405/us/gplugd/tool-chain/arm-marvell-linux-gnueabi.tar.bz2

But since it turns out to be a compiler issue I dont know if its worth 
to be investigated further. I think the best solution to avoid that 
structure alignment problem is to simply use another toolchain.

Dave, I thank you very much for your help and efforts to clarify that 
this is actually not a bug in the kernel.

Thx,
Lino
