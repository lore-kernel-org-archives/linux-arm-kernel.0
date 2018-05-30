From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 30 May 2018 22:49:22 +0800
Subject: [RFT v3 1/4] perf cs-etm: Generate branch sample for missed
 packets
In-Reply-To: <CANLsYkzPShMj1cbXZPb7Lzio+gKcmvhD2+KTYr7vP9ec1d6bmg@mail.gmail.com>
References: <1527497103-3593-1-git-send-email-leo.yan@linaro.org>
 <1527497103-3593-2-git-send-email-leo.yan@linaro.org>
 <20180528221347.GA4109@xps15>
 <20180529002538.GA11317@leoy-ThinkPad-X240s>
 <CANLsYkzEU90aVtPMRqf=YHzee8DHq8JZttRuxjLKGz-gRYiBuw@mail.gmail.com>
 <20180530002837.GB11923@leoy-ThinkPad-X240s>
 <CANLsYkzPShMj1cbXZPb7Lzio+gKcmvhD2+KTYr7vP9ec1d6bmg@mail.gmail.com>
Message-ID: <20180530144922.GB12368@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 08:45:46AM -0600, Mathieu Poirier wrote:
> On 29 May 2018 at 18:28, Leo Yan <leo.yan@linaro.org> wrote:
> > Hi Mathieu,
> >
> > On Tue, May 29, 2018 at 10:04:49AM -0600, Mathieu Poirier wrote:
> >
> > [...]
> >
> >> > As now this patch is big with more complex logic, so I consider to
> >> > split it into small patches:
> >> >
> >> > - Define CS_ETM_INVAL_ADDR;
> >> > - Fix for CS_ETM_TRACE_ON packet;
> >> > - Fix for exception packet;
> >> >
> >> > Does this make sense for you?  I have concern that this patch is a
> >> > fixing patch, so not sure after spliting patches will introduce
> >> > trouble for applying them for other stable kernels ...
> >>
> >> Reverse the order:
> >>
> >> - Fix for CS_ETM_TRACE_ON packet;
> >> - Fix for exception packet;
> >> - Define CS_ETM_INVAL_ADDR;
> >>
> >> But you may not need to - see next comment.
> >
> > From the discussion context, I think here 'you may not need to' is
> > referring to my concern for applying patches on stable kernel, so I
> > should take this patch series as an enhancement and don't need to
> > consider much for stable kernel.
> 
> Yes, that is what I meant.

Thanks for confirmation, will send new patch series according to the
discussion.

[...]

Thanks,
Leo Yan
