From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 2 Oct 2013 08:43:20 -0400
Subject: Armada XP doesn't boot in v3.12-rc3
In-Reply-To: <CAFJTrDvNYa2g-TFPjii5WpCgnX8kc8r9v3+jzL7gkHCwRV-obg@mail.gmail.com>
References: <CAFJTrDvNYa2g-TFPjii5WpCgnX8kc8r9v3+jzL7gkHCwRV-obg@mail.gmail.com>
Message-ID: <20131002124320.GL31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 11:39:53AM +0100, Matthew Minter wrote:
> Hi,
> 
> I am having the same issue as
> "Re: mvebu: Armada XP doesn't boot in v3.12-rc1".
> except that I am running rc3.
> 
> I am wondering if the mentioned patch was ever released as I currently
> have an un-bootable board.

Yes, it's:

  7b0dd72 arm: clocksource: mvebu: Use the main timer as clock source from DT

which made it into v3.12-rc3.

We'll need more information in order to diagnose your problem.  You've
either stumbled across a different problem, or need to try a clean
build.  But I'm just guessing since I'm not in front of your box ;-)

hth,

Jason.
