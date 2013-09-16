From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 16 Sep 2013 09:57:27 +0530
Subject: [PATCH 211/228] cpufreq: tegra: remove calls to
 cpufreq_notify_transition()
In-Reply-To: <32077984.uYNhUh2ogt@vostro.rjw.lan>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <52339729.7030309@wwwdotorg.org>
 <CAKohpono-J-Ohzdn=pbNK+HhXhJ2Lf-UBM7OPynTgAwxLd4F4A@mail.gmail.com>
 <32077984.uYNhUh2ogt@vostro.rjw.lan>
Message-ID: <CAKohponrJerykspkd0b4wtE2YtPRMpphUW_3ZN0Lg9Q6bNdJRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 September 2013 10:35, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Well, I guess you can assume that everyone has a chance to review the series
> by now and send it as one patch in the next iteration.

Yeah, that's what I thought..

> A patch that adds 192 lines of code isn't shockingly large by any measure.

It was more about removal of things and the number of files it touches..
But yes, its good for review to send them separately but in the end they can
be merged..
