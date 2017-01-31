From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Jan 2017 14:45:39 +0000
Subject: [Patch v4 2/2] firmware: qcom: scm: Fix interrupted SCM calls
In-Reply-To: <CAOesGMhRS8hmHqO=T6X3nooztqhwRO_YMDe2F960TnED-tJN-w@mail.gmail.com>
References: <1484845120-3364-1-git-send-email-andy.gross@linaro.org>
 <1484845120-3364-3-git-send-email-andy.gross@linaro.org>
 <CAOesGMi4xUxJNHO5hEbZHBCnTZ6xXVyzoszawPiJxBiRP1DitA@mail.gmail.com>
 <20170130105553.GB16461@arm.com>
 <CAOesGMhRS8hmHqO=T6X3nooztqhwRO_YMDe2F960TnED-tJN-w@mail.gmail.com>
Message-ID: <20170131144539.GE22283@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 10:22:18PM -0800, Olof Johansson wrote:
> On Mon, Jan 30, 2017 at 2:55 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Sun, Jan 29, 2017 at 04:24:51PM -0800, Olof Johansson wrote:
> >> Seems like a more appropriate change than burden all platforms with
> >> longer code path due to your quirk.
> >
> > I really don't think it's a problem. Do you have numbers suggesting
> > otherwise?
> 
> Not on this first quirk, no.
> 
> Anyway, I guess I'm just bikeshedding. You should merge this code if
> you're happy with it.

Ok. Andy, does it work for you if I take these two patches via arm64? I'll
need Russell's ack on the arch/arm/ part.

Will
