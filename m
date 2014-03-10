From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Mon, 10 Mar 2014 14:25:31 +0000
Subject: [PATCH] net: phy: Add sysfs attribute to prevent PHY suspend
In-Reply-To: <531D0D0D.4050703@gmail.com>
References: <531CF864.9040406@gmail.com>
 <20140309.203001.1318893833441564547.davem@davemloft.net>
 <531D094C.1090205@gmail.com>
 <20140309.204101.47552917508273123.davem@davemloft.net>
 <531D0D0D.4050703@gmail.com>
Message-ID: <20140310142531.1fde5797@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Mar 2014 01:53:33 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 03/10/2014 01:41 AM, David Miller wrote:
> > From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Date: Mon, 10 Mar 2014 01:37:32 +0100
> >
> >> The mechanism is manual, no automatic way to determine it.
> >
> > We recognize BIOS and ACPI bugs and work around them, by looking at
> > version information and whatnot, so you really can't convince me that
> > something similar can't be done here perhaps in the platform code.
> 
> Hmm, if the is a way to determine the version of that particual u-boot
> I'd be happy to exploit that information.

If there isn't a way for a kernel to determine the U-boot version then
maybe that should get fixed instead. That also solves your problem
because if you can't find the uboot version you know its too old.

Alan
