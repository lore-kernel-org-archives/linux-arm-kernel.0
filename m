From: bryanh@codeaurora.org (Bryan Huntsman)
Date: Wed, 14 Jul 2010 08:36:44 -0700
Subject: [RFC,PATCH 0/2] Allow late mdesc detection
In-Reply-To: <1279080712.15089.53.camel@pororo.lan>
References: <1278903792.387175.713057245098.0.gpush@pororo>	<alpine.LFD.2.00.1007112334390.10598@xanadu.home>	<1278921935.9235.90.camel@pororo.lan>	<alpine.LFD.2.00.1007120904240.10598@xanadu.home>	<AANLkTikXejaVsFsudO3ABKzR80V6yCBHm7c6y32hurdt@mail.gmail.com>	<20100713072848.GC19839@n2100.arm.linux.org.uk>	<1279011746.2521.394.camel@pororo.lan>	<20100713093346.GC20590@n2100.arm.linux.org.uk>
	<1279080712.15089.53.camel@pororo.lan>
Message-ID: <4C3DD98C.2000302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> be useful without the DT. At present (and as far as I know), Grant and I
> are the only ones doing DT-specific infrastructure changes for ARM.

We did an evaluation of it a few months ago for MSM chips.  IIRC, there 
were a lot of work-arounds needed to accommodate platform data and 
function pointers.  The net result was not a decrease in board file size 
or complexity.  I'll try to find the tree we used and host it somewhere 
for public review.

- Bryan
