From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 10 Sep 2018 09:49:07 -0600
Subject: [PATCH v3 0/9] coresight: Update device tree bindings
In-Reply-To: <9e935bd9-1cd1-0fda-3d73-fe2487759a1c@arm.com>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
 <20180730200232.GA31755@xps15>
 <CANLsYkzBfCydwDO-KyDub4X=GTy_dtv-478RyMReBEH6VybSAg@mail.gmail.com>
 <9e935bd9-1cd1-0fda-3d73-fe2487759a1c@arm.com>
Message-ID: <CANLsYkwpFZcxaNdvcnag_-ywhWyE1yV6BT1sUx8-4i2dMdD8MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Sep 2018 at 09:35, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Mathieu,
>
> On 31/07/18 16:06, Mathieu Poirier wrote:
> > [...]
> >
> >>>
> >>> Suzuki K Poulose (9):
> >>>   coresight: Document error handling in coresight_register
> >>>   coresight: platform: Refactor graph endpoint parsing
> >>>   coresight: platform: Fix refcounting for graph nodes
> >>>   coresight: platform: Fix leaking device reference
> >>>   coresight: Fix remote endpoint parsing
> >>>   coresight: Add helper to check if the endpoint is input
> >>>   coresight: platform: Cleanup coresight connection handling
> >>>   coresight: Cleanup coresight DT bindings
> >>>   dts: juno: Update coresight bindings
> >>>
> >>>  .../devicetree/bindings/arm/coresight.txt          |  95 +++++---
> >>>  arch/arm64/boot/dts/arm/juno-base.dtsi             | 161 ++++++------
> >>>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi          |  52 ++--
> >>>  arch/arm64/boot/dts/arm/juno.dts                   |  13 +-
> >>>  drivers/hwtracing/coresight/coresight.c            |  35 +--
> >>>  drivers/hwtracing/coresight/of_coresight.c         | 269 ++++++++++++++-------
> >>>  include/linux/coresight.h                          |   9 +-
> >>>  7 files changed, 359 insertions(+), 275 deletions(-)
> >>>
> >>
> >> Good day,
> >>
> >> I have applied patches 1 to 7.  I will wait for Rob's ACK before doing the same
> >> with 8 and 9.
> >
> > I just applied patch 8 and 9.
> >
> Sorry for the delay, but ARM SoC expects all the DTS changes to go via
> their tree. Please drop patch 9, I will route via ARM-SoC.

Done - it's all yours now.

Mathieu

>
> --
> Regards,
> Sudeep
