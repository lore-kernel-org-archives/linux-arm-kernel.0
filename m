From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 27 Mar 2013 10:00:20 +0100
Subject: [RFC PATCH v3 3/6] sched: pack small tasks
In-Reply-To: <CAKfTPtAox+h0YmpP6W==hJ5FaNzDfF8bQmadmU86MrfnJt67QQ@mail.gmail.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-4-git-send-email-vincent.guittot@linaro.org>
 <1364301998.5053.17.camel@laptop> <5151BEF2.9090100@linux.intel.com>
 <1364373980.5053.57.camel@laptop>
 <CAKfTPtAox+h0YmpP6W==hJ5FaNzDfF8bQmadmU86MrfnJt67QQ@mail.gmail.com>
Message-ID: <1364374820.5053.63.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-27 at 09:54 +0100, Vincent Guittot wrote:
> It's not mandatory to have little cores on low numbers even if it's
> advised

ARGH!
