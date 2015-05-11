From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 11 May 2015 17:12:14 +0530
Subject: [PATCH v3 2/7] clocksource: add lpc32xx timer driver
In-Reply-To: <55509494.2050008@linaro.org>
References: <1431017317-23740-1-git-send-email-manabian@gmail.com>
 <1431017317-23740-3-git-send-email-manabian@gmail.com>
 <55508CE3.6000008@linaro.org>
 <CAGhQ9VxnBrT3KO11MAzi_bDQwCAvBPwWtZ3FhV6qKc+foK472w@mail.gmail.com>
 <55509494.2050008@linaro.org>
Message-ID: <20150511114214.GA19714@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-05-15, 13:37, Daniel Lezcano wrote:
> On 05/11/2015 01:30 PM, Joachim Eastwood wrote:
> >Has any other drivers been switched over that I could take a look at?
> 
> Not I am aware of. Viresh [Cc'ed] has a bunch of driver changes in
> its log to send, may be he can send you one you can look at.

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git	clkevt/migrate-to-new-per-state-api

NOTE: I haven't tried to upstream any of this yet. Waiting for some other
changes to get merged first.
