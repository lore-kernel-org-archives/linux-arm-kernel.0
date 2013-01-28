From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Jan 2013 11:10:20 -0500
Subject: [GIT PULL V2 2/4] ARM: mvebu: drivers for v3.9
In-Reply-To: <87fw1la5h7.fsf@laptop.org>
References: <1358909285.ca5b742.21555@triton>
 <20130128055304.GA25723@quad.lixom.net> <87fw1la5h7.fsf@laptop.org>
Message-ID: <20130128161020.GJ1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 06:53:40AM -0500, Chris Ball wrote:
> Hi,
> 
> On Mon, Jan 28 2013, Olof Johansson wrote:
> > I didn't see any acks by Chris Ball on these, he's usually pretty
> > responsive on code reviews so I just wanted to make sure he's OK with
> > us taking this through arm-soc, and aware of it.
> >
> > Looks like this whole branch could go through the mmc tree? The dtsi
> > updates from the last branch would still go through arm-soc.
> 
> Thanks for the ping, would be good to take these via mmc-next so I've
> pushed the four new mvsdio patches there now:
> 
> mmc: mvsdio: add pinctrl integration
> mmc: mvsdio: implement a Device Tree binding
> mmc: mvsdio: use slot-gpio for card detect gpio
> mmc: mvsdio: use slot-gpio infrastructure for write protect gpio

Thanks Chris, I'll redo these and depend on mmc-next at

git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git

thx,

Jason.
