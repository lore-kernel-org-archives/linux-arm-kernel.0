From: LinoSanfilippo@gmx.de (Lino Sanfilippo)
Date: Sun, 22 Mar 2015 01:56:10 +0100
Subject: [RFC PATCH 0/1] Wrong structure alignment due to compiler
 attribute "section"
In-Reply-To: <54F9EFE2.2020205@gmx.de>
References: <1425290502-2322-1-git-send-email-lsanfil@marvell.com>
 <20150303144130.GB5177@e103592.cambridge.arm.com>
 <54F6EF32.7080306@marvell.com>
 <20150304143527.GA5653@e103592.cambridge.arm.com>
 <54F732DA.2050004@marvell.com>
 <20150305122606.GC3612@e103592.cambridge.arm.com>
 <54F8582B.80703@marvell.com>
 <20150305134733.GE3612@e103592.cambridge.arm.com>
 <54F8770C.8080709@marvell.com>
 <20150305173327.GF3612@e103592.cambridge.arm.com>
 <54F9B36F.8040307@marvell.com> <54F9EFE2.2020205@gmx.de>
Message-ID: <550E132A.7050304@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.03.2015 19:20, Lino Sanfilippo wrote:
> 
>>>
>> 
>> Ok, I got a link to the source now. It can be found here:
>> 
>> http://tp-lab200/release/gcc/temp/internal/2010q4-113-4.4.5/marvell-gcc.src-2010q4-113.tar.bz2
>> 
> 
> 
> Sigh. Just realized that the url is not accessible. Will check that on
> monday.
> 
> Lino
> 

Hello Dave,

sorry for my late reply. But I was a few days out of office and had to
contact some people which are not in my departement. The outcome is:
there is no public repository in which the source code of that special
(buggy) toolchain is available any more. There are newer versions
already, but even for those the source code is only accessible for
customers (thats what I was told). However the responsible developer
could confirm that the wrong alignment I initially reported is indeed a
bug in the toolchain which now is fixed in the newer versions.
I really would have liked to send you the source, but unfortunately I
cant. However thanks again for all your help.

Regards,
Lino
