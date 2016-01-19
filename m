From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Jan 2016 21:10:49 +0000
Subject: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
In-Reply-To: <569E92FF.4000006@linaro.org>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
 <56994D87.6000709@linaro.org> <20160118151316.GD7159@e106622-lin>
 <CAKfTPtBFR4cowT-j4qVxfUvh6NDNmi6R=J7z9kywi6bONU3Pow@mail.gmail.com>
 <20160118163014.GA10332@e106622-lin>
 <CAKfTPtDJBAXUz=_-QQSkrqwAvmUJd1bUJ-VfSaNER-0NzWpunA@mail.gmail.com>
 <20160119105941.GA28845@e104818-lin.cambridge.arm.com>
 <20160119112323.GB8573@e106622-lin>
 <20160119142933.GF8573@e106622-lin> <569E92FF.4000006@linaro.org>
Message-ID: <20160119211049.GX6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 11:48:15AM -0800, Steve Muckle wrote:
> On 01/19/2016 06:29 AM, Juri Lelli wrote:

> > I'm generally seeing ~1sec increase in boot time for 1 and practically
> > no difference for 2 (even after having added patches that provide
> > runtime performance improvements).

> One second is considerable IMO. Aside from the general desire to have
> shorter boot times on any platform there are environments like
> automotive where boot time is critical.

Yeah, definitely.  Is this actually blocking boot and if so can we
arrange to do this in parallel with other activity (with likely knock on
effects on reproducibility...)?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160119/97a243b4/attachment.sig>
