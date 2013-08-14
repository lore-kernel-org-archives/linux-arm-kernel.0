From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 21:46:45 -0700
Subject: [GIT PULL] Reset controller changes for 3.12
In-Reply-To: <1375100171.4223.10.camel@pizza.hi.pengutronix.de>
References: <1375100171.4223.10.camel@pizza.hi.pengutronix.de>
Message-ID: <20130814044645.GA16635@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Phillip,

On Mon, Jul 29, 2013 at 02:16:11PM +0200, Philipp Zabel wrote:
> Hi Olof,
> 
> with the cosmetic issues pointed out by Ben and Sylwester fixed in the
> gpio-reset driver, the following changes since commit
> 5ae90d8e467e625e447000cb4335c4db973b1095:
> 
>   Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git reset/for_v3.12
> 
> for you to fetch changes up to f4d36f8a5166405154c638c1e49e253f2f017dd7:
> 
>   reset: allow drivers to request probe deferral (2013-07-29 14:03:40
> +0200)

I'm not going to pull this for 3.12 -- or at least not at this
time. There's still too much active discussion on whether we even want
this, and the only existing reset driver so far is the one that isn't
really needed (i.e. the gpio one).

I'd prefer to wait until we have one that actually is needed, and that
can't be described using gpios like we already have for a long time.


-Olof
