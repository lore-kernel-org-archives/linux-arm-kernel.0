From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 16 Jun 2015 23:21:39 +0200
Subject: [PATCH V7 3/3] OPP: Add binding for 'opp-suspend'
In-Reply-To: <CAL_JsqJ2gCJvtrZqDWWoY6Gv4Ag7xLV93wLbT5b37jO=oWo+MQ@mail.gmail.com>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
 <20150616025425.GB26592@linux>
 <CAL_JsqJ2gCJvtrZqDWWoY6Gv4Ag7xLV93wLbT5b37jO=oWo+MQ@mail.gmail.com>
Message-ID: <4228747.vs1U0RqIQB@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 16, 2015 02:23:23 PM Rob Herring wrote:
> On Mon, Jun 15, 2015 at 9:54 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 16-06-15, 06:01, Viresh Kumar wrote:
> >> On 16 June 2015 at 05:05, Rob Herring <robherring2@gmail.com> wrote:
> >> >> +- opp-suspend: Phandle of the OPP to set while device is suspended.
> >> >> +
> >> >
> >> > I would just do a bool property in the OPP you want.
> >>
> >> I will do that if you want, no big deal.
> >
> > In order to not waste any time, here is the change you suggested. Ack
> > the one (original change or this one) you like :)
> >
> > ------------------8<----------------------
> >
> > From: Viresh Kumar <viresh.kumar@linaro.org>
> > Date: Wed, 20 May 2015 08:27:49 +0530
> > Subject: [PATCH V8] OPP: Add binding for 'opp-suspend'
> >
> > On few platforms, for power efficiency, we want the device to be
> > configured for a specific OPP while we put the device in suspend state.
> >
> > Add an optional property in operating-points-v2 bindings for that.
> >
> > Acked-by: Nishanth Menon <nm@ti.com>
> > Suggested-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V7->V8:
> > - opp-suspend is moved to OPPs instead of the table, and is bool now.
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks!

Does your ACK also apply to patches [1-2/3] in this series?

Rafael
