From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 13 Jun 2012 15:32:48 +0200
Subject: [RFC 3/4] ARM: topology: Update cpu_power according to DT
 information
In-Reply-To: <CAKfTPtCyV389OTrun5Oyn8RCsDagza95wdmWr=r9poMiYrU0Mg@mail.gmail.com>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-4-git-send-email-vincent.guittot@linaro.org>
 <CAORVsuWqWt0pJfewymh_ydAH61-uPsO0M7m7Gs4N3zJY=Vo9ZA@mail.gmail.com>
 <CAKfTPtBc-KuDg_1qe04TfYS4+66qQoiHCJQbCF9gnhga5ociow@mail.gmail.com>
 <CAP245DXEOGLe1jq2Wj0rNW5qea63UyJu2jOvwV65Y4B9LLoQtg@mail.gmail.com>
 <1339591666.8980.26.camel@twins>
 <CAKfTPtCyV389OTrun5Oyn8RCsDagza95wdmWr=r9poMiYrU0Mg@mail.gmail.com>
Message-ID: <1339594368.8980.41.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-13 at 15:29 +0200, Vincent Guittot wrote:
> In fact, there is 2 tracks, one for a power aware scheduler and one
> for setting the capacity of each core of a big.LITTLE system. This
> patch is for the latter and is not directly link to the power because
> the default/performance mode of the scheduler should also take
> advantage of this information 

Fair enough.. can you include a little blurp in the changelog on how
this affects the capacity stuff for big.little and if that works as
desired due to these patches?
