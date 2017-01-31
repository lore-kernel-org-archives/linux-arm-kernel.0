From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 31 Jan 2017 10:03:51 -0600
Subject: [Patch v4 2/2] firmware: qcom: scm: Fix interrupted SCM calls
In-Reply-To: <20170131144539.GE22283@arm.com>
References: <1484845120-3364-1-git-send-email-andy.gross@linaro.org>
 <1484845120-3364-3-git-send-email-andy.gross@linaro.org>
 <CAOesGMi4xUxJNHO5hEbZHBCnTZ6xXVyzoszawPiJxBiRP1DitA@mail.gmail.com>
 <20170130105553.GB16461@arm.com>
 <CAOesGMhRS8hmHqO=T6X3nooztqhwRO_YMDe2F960TnED-tJN-w@mail.gmail.com>
 <20170131144539.GE22283@arm.com>
Message-ID: <20170131160351.GC2821@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 02:45:39PM +0000, Will Deacon wrote:
> On Mon, Jan 30, 2017 at 10:22:18PM -0800, Olof Johansson wrote:
> > On Mon, Jan 30, 2017 at 2:55 AM, Will Deacon <will.deacon@arm.com> wrote:
> > > On Sun, Jan 29, 2017 at 04:24:51PM -0800, Olof Johansson wrote:
> > >> Seems like a more appropriate change than burden all platforms with
> > >> longer code path due to your quirk.
> > >
> > > I really don't think it's a problem. Do you have numbers suggesting
> > > otherwise?
> > 
> > Not on this first quirk, no.
> > 
> > Anyway, I guess I'm just bikeshedding. You should merge this code if
> > you're happy with it.
> 
> Ok. Andy, does it work for you if I take these two patches via arm64? I'll
> need Russell's ack on the arch/arm/ part.

FYI, there is a new version that fixes an issue with hvc.  I missed this as we
don't exercise that code path.

As for taking it via arm64, that's fine.  I'm not sure how to get his ACK aside
from emailing the patches.


Andy
