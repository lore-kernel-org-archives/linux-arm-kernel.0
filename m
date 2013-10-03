From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 3 Oct 2013 07:45:41 -0400
Subject: Armada XP doesn't boot in v3.12-rc3
In-Reply-To: <20131003122801.7f72bc26@skate>
References: <CAFJTrDvNYa2g-TFPjii5WpCgnX8kc8r9v3+jzL7gkHCwRV-obg@mail.gmail.com>
 <20131002124320.GL31178@titan.lakedaemon.net>
 <CAFJTrDsTmSzFEX7XVqnw4=vYiBdqNeLDQuWFotSEZqGsFxT9sA@mail.gmail.com>
 <20131002202547.GA10645@localhost>
 <CAFJTrDsiOfG1rNWo3OXtzdcquP8kdS+_x2YYELOQDH96SLGm_A@mail.gmail.com>
 <20131003122801.7f72bc26@skate>
Message-ID: <20131003114541.GT31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 12:28:01PM +0200, Thomas Petazzoni wrote:
> Dear Matthew Minter,
> 
> On Thu, 3 Oct 2013 10:41:07 +0100, Matthew Minter wrote:
> 
> > It seems the latest build of "for-next" from
> > git://git.infradead.org/linux-mvebu.git works the charm.

Great!

> As soon as the relevant fixes of mvebu/for-next hit mainline, you'll be
> able to switch back to using the mainline kernel. Note that you can
> also use 3.11 for the moment, which should also work on this platform.

It looks like Linus pulled from arm-soc/fixes last night, so you may
want to give mainline a try.  I rebase mvebu/for-next frequently, so
it's not stable.  It's purpose is for quick verification as you did
yesterday, not extended use.

hth,

Jason.
