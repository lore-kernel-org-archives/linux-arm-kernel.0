From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Jul 2010 08:28:48 +0100
Subject: [RFC,PATCH 0/2] Allow late mdesc detection
In-Reply-To: <AANLkTikXejaVsFsudO3ABKzR80V6yCBHm7c6y32hurdt@mail.gmail.com>
References: <1278903792.387175.713057245098.0.gpush@pororo>
	<alpine.LFD.2.00.1007112334390.10598@xanadu.home>
	<1278921935.9235.90.camel@pororo.lan>
	<alpine.LFD.2.00.1007120904240.10598@xanadu.home>
	<AANLkTikXejaVsFsudO3ABKzR80V6yCBHm7c6y32hurdt@mail.gmail.com>
Message-ID: <20100713072848.GC19839@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 01:44:59PM +0800, Eric Miao wrote:
> With the introduction of 'struct machine_class', I guess this is especially
> true for 1 SoC for one DT machine ID :-)
> 
> Finally, if we can decide the 'struct machine_class' by something else,
> then we can merge all DT machine IDs into one or completely ignore it.

As far as I can see, DT isn't getting anywhere - certainly my request
to see it on a real platform rather than the ARM Ltd hardware seems to
have been "forgotten" about.

As it's taking soo long (it's getting to be a couple of years) to come
up with a DT implementation for a real machine, I can only think that
there must be some massive problem(s) with DT which makes it completely
unsuitable for use on ARM.
