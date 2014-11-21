From: johannes.pointner@gmail.com (Johannes Pointner)
Date: Fri, 21 Nov 2014 19:17:18 +0100
Subject: [PATCH v4 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
In-Reply-To: <546F5C27.7040004@ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-4-git-send-email-vigneshr@ti.com>
 <20141118143005.GF24004@x1> <20141118171240.GB3003@dtor-ws>
 <546DF2F0.9080405@ti.com>
 <20141120144028.GB5809@localhost.localdomain>
 <546F2BA4.4000808@ti.com>
 <20141121131036.GA18931@localhost.localdomain>
 <CAJKbBDDVTA+=priRu7sCD=vHrC8AUg4DM3kycuGrqbpF-5FGAA@mail.gmail.com>
 <546F5C27.7040004@ti.com>
Message-ID: <CAJKbBDD=eYmU=LuViwLPNV=kYCziDQgKjL07bT7og4vsj0Ee7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before the patches were also jumps but I thought it is something
Vignesh should know. Maybe there is some fix for that too?
As Richard also noted, it would be nice if ti could let us know how to
get the delay values right. By trial and error is IMHO not the best
way.
For the testing I used 3.16.7.


2014-11-21 16:37 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Friday 21 November 2014 08:41 PM, Johannes Pointner wrote:
>> I tested version 4 of the patch series on a custom design and I saw
>> also the jumps as described by Richard. I played a little with the
>> sample delay and it got better but I couldn't completely remove the
>> jumps.
>
> And before the patches were applied, there were no jumps at all? Which
> kernel are you using for testing?
>
> Thanks,
> Sekhar
