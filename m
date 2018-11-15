From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Nov 2018 06:42:45 -0800
Subject: [RFC PATCH 07/12] soc: qcom: ipa: IPA register abstraction
In-Reply-To: <e9114caf-0c92-7cac-33cd-6bea548b0375@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-8-elder@linaro.org>
 <CAK8P3a2FsgR=SYAWsgFURVni1ReiCugKs1iUAfQzZhPkbW8aOA@mail.gmail.com>
 <e9114caf-0c92-7cac-33cd-6bea548b0375@linaro.org>
Message-ID: <CAK8P3a1RKVYRhM7OtUK3BhPj=jip2-j_8ziW_6Z5rnhFCTOOUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 6:48 PM Alex Elder <elder@linaro.org> wrote:
>
> On 11/7/18 9:00 AM, Arnd Bergmann wrote:
> > On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
> >> diff --git a/drivers/net/ipa/ipa_reg.c b/drivers/net/ipa/ipa_reg.c
> >> new file mode 100644
> >> index 000000000000..5e0aa6163235
> >> --- /dev/null
> >> +++ b/drivers/net/ipa/ipa_reg.c
> >> @@ -0,0 +1,972 @@

> It may be that this parse/construct mechanism isn't justified
> at this point.  I thought the way it presented a generic
> interface was useful, but with just one (initial) hardware
> target we don't (yet) realize its potential benefit.  It could
> be added back later, as support for new versions is added.
>
> As of now I don't plan to change this, but if you or someone
> else feels it would be better without it I can do that.

Fair enough. I do think that it would be better to avoid this, but
it's much less important than the other issues I mentioned,
so please put this on the bottom of your priorities list, we
can talk about it again when we get closer to merging the driver.

     Arnd
