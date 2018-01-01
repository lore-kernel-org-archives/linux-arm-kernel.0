From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 1 Jan 2018 00:23:50 -0600
Subject: [PATCH v2 0/3] arm64: defconfig: remove some Qualcomm USB options
In-Reply-To: <18cfab8f-e7c8-5881-19c7-5807ca090c8b@linaro.org>
References: <20171031125808.7300-1-elder@linaro.org>
 <CAK8P3a0r8NZdbv8KYyF72oXU_3gxBD2ETzY+BZUf4i5V4Lr=mw@mail.gmail.com>
 <18cfab8f-e7c8-5881-19c7-5807ca090c8b@linaro.org>
Message-ID: <20180101062350.GA30924@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 07:47:54AM -0500, Alex Elder wrote:
> On 11/02/2017 04:15 AM, Arnd Bergmann wrote:
> > On Tue, Oct 31, 2017 at 1:58 PM, Alex Elder <elder@linaro.org> wrote:
> >> This series deletes three config options related to USB on Qualcomm
> >> SoCs from the arm64 "defconfig".  The code enabled by the options is
> >> no longer needed by any Qualcomm hardware.  The driver code that
> >> corresponds to these config options is removed in a separate series.
> >>
> >>                                         -Alex
> >>
> >> v2:  Added Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> > 
> > The patches look good. Should we apply them directly to arm-soc, or is
> > Andy going to forward them? Normally I'd wait for him to apply them,
> > but I see he has already given an Ack, so I don't know what to do here.
> 
> Andy should answer, but my preference would be for you to apply them
> directly.  As long as they have your attention right now you might as
> well.  I suppose you could just do that and win the race with Andy...

I'll queue them up.  I've been late in getting to these.  Apologies for that.


Andy
