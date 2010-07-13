From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 13 Jul 2010 17:02:26 +0800
Subject: [RFC,PATCH 0/2] Allow late mdesc detection
In-Reply-To: <20100713072848.GC19839@n2100.arm.linux.org.uk>
References: <1278903792.387175.713057245098.0.gpush@pororo>
	<alpine.LFD.2.00.1007112334390.10598@xanadu.home>
	<1278921935.9235.90.camel@pororo.lan>
	<alpine.LFD.2.00.1007120904240.10598@xanadu.home>
	<AANLkTikXejaVsFsudO3ABKzR80V6yCBHm7c6y32hurdt@mail.gmail.com>
	<20100713072848.GC19839@n2100.arm.linux.org.uk>
Message-ID: <1279011746.2521.394.camel@pororo.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> As far as I can see, DT isn't getting anywhere - certainly my request
> to see it on a real platform rather than the ARM Ltd hardware seems to
> have been "forgotten" about.

No, definitely not forgotten.

In addition to versatile, I have mx51 booting with a device tree at the
moment. The patches are still a little hackish (and a little behind
mainline now), but the basic support is there.

If you'd like a solid demo of mx51, I can get these patches updated to
my most recent arm-dt branch.

> As it's taking soo long (it's getting to be a couple of years) to come
> up with a DT implementation for a real machine,

It's been about 5 months since I started work on DT on ARM; I'm not sure
who's been working on it previously, if anyone.

So far, most of the time has been preparation work - things like the clk
infrastructure, and smaller bits like these addruart patches. We're (me,
gcl and nico) also working carefully to specify the interfaces and
standards correctly, for example getting the boot interface right, and
standard formats for ARM device representation in the DT.

So no, there are no massive problems, it's coming along.

Cheers,


Jeremy
