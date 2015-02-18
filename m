From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 18 Feb 2015 13:40:06 +0000
Subject: [PATCH 0/2] arm/arm64: Detect Xen support earlier
In-Reply-To: <54E481D6.2080908@linaro.org>
References: <1423722898-16110-1-git-send-email-julien.grall@linaro.org>
 <1424259059.27775.17.camel@citrix.com> <54E47CBD.7060002@linaro.org>
 <1424260988.27775.26.camel@citrix.com> <54E481D6.2080908@linaro.org>
Message-ID: <1424266806.27775.55.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-02-18 at 12:13 +0000, Julien Grall wrote:
> 
> On 18/02/2015 12:03, Ian Campbell wrote:
> > On Wed, 2015-02-18 at 11:51 +0000, Julien Grall wrote:
> >> Hi Ian,
> >>
> >> On 18/02/2015 11:30, Ian Campbell wrote:
> >>> On Thu, 2015-02-12 at 06:34 +0000, Julien Grall wrote:
> >>>> Hello,
> >>>>
> >>>> This small patch series move the detection of running on Xen earlier. This is
> >>>> required in order to support earlyprintk via Xen and selecting the preferred
> >>>> console.
> >>>
> >>> Thanks for doing this, having all of the init done in an initcall (even
> >>> a relatively early one) has been a niggle I've wanted address for ages,
> >>> for exactly earlyprintk and preferred console reasons.
> >>>
> >>> I had a very minor comment on #1 but nonetheless both patches:
> >>> Acked-by: Ian Campbell <ian.campbell@citrix.com>
> >>
> >> Can I keep you ack on the first one with the __read_mostly dropped?
> >
> > Sure.
> >
> > BTW, when reposting you might want to CC the arch/arm* maintainers on
> > this intro mail as well as just the second patch.
> 
> Ok. I wasn't sure if this patches should go via the Xen tree or ARM one.

That's a question for all relevant maintainers to discuss -- and replies
to the 0/N mail is a good place to do that. I suggest you explicitly ask
the question in the intro next time around.

Ian.
