From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 May 2015 11:57:14 +0100
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150504121209.GM15510@sirena.org.uk>
 <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
Message-ID: <20150505105714.GA22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 04:18:59PM +0530, Viresh Kumar wrote:
> On 4 May 2015 at 17:42, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Apr 30, 2015 at 05:37:59PM +0530, Viresh Kumar wrote:

> >> +- opp-microamp: current in micro Amperes. It can contain entries for multiple
> >> +  regulators.
> >> +
> >> +  A single regulator's current is specified with an array of size one or three.
> >> +  Single entry is for target current and three entries are for <target min max>
> >> +  currents.

> > What is this for - are you trying to define OPPs for current regulators?
> > If you are that's worrying, I can't think of a sensible use case.  If
> > that's not what's happening then the binding needs to be more specific
> > about what this is supposed to mean.

> Its another property of the same voltage regulator we are using in
> opp-microvolt.
> I hope that makes sense ?

No, it doesn't - you're not answering the question about what this is
for.

> But, perhaps I need to write it with more clarity? Or this field doesn't make
> sense ?

To know if this makes sense I need to know what you beleive "setting the
current" does.  If you literally mean setting the current it makes no
sense at all.  If you mean something else that something else should
probably be written into the binding.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150505/d1a290d5/attachment.sig>
