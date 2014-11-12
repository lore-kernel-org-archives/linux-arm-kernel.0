From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Nov 2014 10:48:07 +0000
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <CAOesGMiscbWfbpxwPxkH+7_4mhK=5+4nQJrWvgHfbsLJYhO1cg@mail.gmail.com>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <20141024094412.GN27405@n2100.arm.linux.org.uk>
 <20141024182509.GA31232@gate.crashing.org>
 <2480226.26bJjjL2fl@wuerfel>
 <CAOesGMiscbWfbpxwPxkH+7_4mhK=5+4nQJrWvgHfbsLJYhO1cg@mail.gmail.com>
Message-ID: <20141112104807.GZ4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 05:34:54PM -0800, Olof Johansson wrote:
> Hey, look at that:
> 
> http://arm-soc.lixom.net/buildlogs/misc/v3.18-rc2/
> 
> I've updated the toolchain now, so new builds should be using the proper one.
> 
> Thanks a lot for figuring this out. Segher, feel free to update your
> scripts -- I've got a local edit for it here now. :)

Great, thanks Olof and others for fixing this.  Now all we need is for
people to fix their warnings/errors in the latest -next build, some of
which have been hanging around for some time.  Like the irq_reg_readl()
error for the Marvell platforms...

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
