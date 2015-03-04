From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 4 Mar 2015 10:35:47 +0800
Subject: [PATCH 1/2] cpufreq-dt: support cluster level clock
In-Reply-To: <CAKohponQ1keZ3x9mK=9qchfwPF=cYKAA9aYgmu52X5NDGJLECg@mail.gmail.com>
References: <1425387817-11382-1-git-send-email-leo.yan@linaro.org>
 <1425387817-11382-2-git-send-email-leo.yan@linaro.org>
 <CAKohpoksXwMRWYzSBmbV1nN5_LvUiB1Y2wfgOcCJPx+oipaXZw@mail.gmail.com>
 <20150303140331.GA11325@leoy-linaro>
 <CAKohponQ1keZ3x9mK=9qchfwPF=cYKAA9aYgmu52X5NDGJLECg@mail.gmail.com>
Message-ID: <20150304023547.GB21106@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 08:49:25PM +0530, Viresh Kumar wrote:
> On 3 March 2015 at 19:33, Leo Yan <leo.yan@linaro.org> wrote:
> > I'm just thinking to finish things in one time. From my previous
> > experience, clocks per cluster are common cases for ARM's
> > multi-clusters, so i think it's reasonable to add related support.
> 
> Yes they are common, but that will be fixed with new OPP bindings
> I am working on [1].

Good to know this and looking forward the patches...

> > Regarding of testing this patch, i created two virtual clocks for
> > every cluster and passed the test. Do u think this is acceptable?
> 
> Just to confirm again, we aren't going to accept or apply these
> patches. It will work without any changes for you, for now.

OK, i will go back to just support for the case of one clock source.

> --
> viresh
> 
> [1] https://www.marc.info/?l=linaro-kernel&m=142364262800650&w=3
