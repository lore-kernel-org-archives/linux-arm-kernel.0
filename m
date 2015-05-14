From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 14 May 2015 10:19:18 -0700
Subject: [PATCHv2 1/3] arm64: Mark PMU interrupt IRQF_NO_THREAD
In-Reply-To: <20150514171056.GH18984@arm.com>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
 <1430167990-12333-2-git-send-email-anders.roxell@linaro.org>
 <20150514153937.GB13442@linutronix.de>
 <20150514154215.GE18984@arm.com>
 <CAMAWPa_UA3GgHGkcYkgUJUB8Y6KJS38z-2-=E6PKmGT=tGWh3A@mail.gmail.com>
 <20150514171056.GH18984@arm.com>
Message-ID: <CAMAWPa-G81bUNr5q1a0tpE3LswU2b0KBi4HagL_g0dG-Je0Z5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 10:10 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, May 14, 2015 at 06:09:23PM +0100, Kevin Hilman wrote:

[...]

>> Which tree is at applied to?  I'm not seeing it in -next, and couldn't
>> find it in any branches of the arm64 tree[1].  Sorry to pester, I'm
>> just looking to cherry-pick it from it's proper upstream for testing
>> with a stable/3.18 based kernel.
>
> I don't think Catalin has started putting together our for-next/core branch
> yet, but I'd expect it to appear there when he picks it up.

Cool, thanks.

Kevin
