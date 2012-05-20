From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 19 May 2012 22:43:54 -0600
Subject: [PATCH 05/10] ARM: Samsung: Update the device names for spi clock
 lookup
In-Reply-To: <20120513145134.GA6381@opensource.wolfsonmicro.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-6-git-send-email-thomas.abraham@linaro.org>
 <20120509085249.GA28702@sirena.org.uk>
 <CAJuYYwQ+Wn11puF7AdPD41Jntbuj7oZHqNfzQA2T8V=2cigQnw@mail.gmail.com>
 <20120509142836.GT3955@opensource.wolfsonmicro.com>
 <CAJuYYwSTJoNRuN87GoTZMgF-qahbu02kJ9SUd7omQ5WD0VjTww@mail.gmail.com>
 <20120513145134.GA6381@opensource.wolfsonmicro.com>
Message-ID: <20120520044354.C5DBE3E03B8@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 13 May 2012 15:51:35 +0100, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, May 10, 2012 at 01:17:32AM +0800, Thomas Abraham wrote:
> > On 9 May 2012 22:28, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > > This means that bisection will be broken - anything with only one tree
> > > won't be able to load the SPI driver successfully until it's merged
> > > with the other which isn't ideal.
> 
> > Yes, we would have that problem until the two trees are merged. But I
> > still prefer not to squash the two patches which already contain huge
> > diff.
> 
> I'd not say the diff is *that* big (and most of what's there is simple
> and repetitive), and bisection is a very useful tool.  I know I
> frequently find it enormously painful trying to figure out breakage when
> large chunks of the history don't work usefully.

I agree.  Squash them!

g.


-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
