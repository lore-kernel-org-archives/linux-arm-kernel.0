From: tyler.baker@linaro.org (Tyler Baker)
Date: Tue, 7 Apr 2015 10:08:38 -0700
Subject: Build regression in next-20150331
In-Reply-To: <20150403142424.GJ27490@worktop.programming.kicks-ass.net>
References: <CANMBJr68RVNgVpkDohyOeH=wd=UgKBCFeuveqiUyNcQ_7vendQ@mail.gmail.com>
 <20150402082917.GS23123@twins.programming.kicks-ass.net>
 <CANMBJr4T5T6tFM+SPs9btc_qBRdMPL0QA4R_d1XXk7VBDqq_MA@mail.gmail.com>
 <2449654.mrTjPJtNze@vostro.rjw.lan>
 <20150403142424.GJ27490@worktop.programming.kicks-ass.net>
Message-ID: <CANMBJr44G6rBQ34u7cQ+rypeRXGtiGaAU-dG5Oimr6kUhz0K+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2015 at 07:24, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Apr 03, 2015 at 01:07:19PM +0200, Rafael J. Wysocki wrote:
>> Peter, I'm assiming that you'll make sure this goes into tip/timers/core.
>
> I'll double check, but I think Ingo did a similar thing when he applied
> your patches.

Fix has been included next-20150407, this build regression is resolved[0].

Thanks,

Tyler

[0] http://kernelci.org/build/next/kernel/next-20150407/
