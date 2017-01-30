From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Jan 2017 14:44:08 +0000
Subject: mvneta MDIO problems
In-Reply-To: <20170130103628.09178f50@free-electrons.com>
References: <1485351412.5441.82.camel@beck.ac>
 <20170130103628.09178f50@free-electrons.com>
Message-ID: <20170130144407.GC25924@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jasmin, Thomas,

On Mon, Jan 30, 2017 at 10:36:28AM +0100, Thomas Petazzoni wrote:
> On Wed, 25 Jan 2017 14:36:52 +0100, Jasmin Beck wrote:
...
> > If you are interested in taking a look at the situation in "failed
> > state", I can immediately provide ssh access to the serial console
> > (though your ssh public key is needed in this case).
> 
> I don't think we ever had similar reports. I'm not personally leaving
> the Mirabox running for extended periods of time, so I've never seen
> this issue. We do have the Mirabox tested as part of kernelci.org, but
> it gets rebooted for every test, so we don't see this sort of issue.
> 
> Jason, Andrew, maybe you are running Mirabox boards for extended periods
> of time? If so, have you seen a similar problem?

I do have a Mirabox running 24/7 and I've experienced the same issue.
To date, I thought I was the only one, and that it was probably due to
my funky printer that kicks down to 10MBit/half when in low power state.

I reported it a month or so ago via irc, but at the time blamed the
printer.  I'd love to dive in and fix it.

Mine is currently running 4.8.6 with one patch on top for ath9k.  Let
me know what kernel you want me to move to.

It was also a problem with 4.2.8, which was the kernel I installed when
I first stood up that box.

thx,

Jason.
