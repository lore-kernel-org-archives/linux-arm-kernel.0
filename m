From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Jan 2015 18:25:05 +0530
Subject: [RFC V2] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150123115206.GT21293@sirena.org.uk>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
 <1422013154.29475.11.camel@pengutronix.de>
 <20150123115206.GT21293@sirena.org.uk>
Message-ID: <CAKohponBQkhoSDi1RT5nW=TfKO7rgjbz1DjVHpUS+nYKs4RYjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 January 2015 at 17:22, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jan 23, 2015 at 12:39:14PM +0100, Lucas Stach wrote:

> I tend to agree that this is clearer.  It might be nice to have variants
> for specifying directly as a percentage but I don't think it's really
> worth the complexity.

> If we change the binding to be typ/min/max rather than min/typ/max then
> we could also do this by allowing either one or three values to be
> specified.  That might be more worth the complexity especially given...

+1

>> > +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
>
>> Please let's drop this.
>
> DT bindings are supposed to be stable, this means the code should accept
> old bindings and they should be documented as deprecated.

Yes, I have marked the earlier OPP bindings as deprecated. Will mark
this one too separately.
