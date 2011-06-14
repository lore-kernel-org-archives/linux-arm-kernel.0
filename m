From: linux_arm@lakedaemon.net (Jason)
Date: Tue, 14 Jun 2011 18:08:43 -0400
Subject: [PATCH 0/2 RFC] arm/kirkwood: add dreamplug support.
In-Reply-To: <201106150001.08606.michael@walle.cc>
References: <cover.1308080024.git.jason@lakedaemon.net>
	<201106150001.08606.michael@walle.cc>
Message-ID: <20110614220843.GB15886@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 12:01:08AM +0200, Michael Walle wrote:
> Am Dienstag 14 Juni 2011, 21:52:53 schrieb linux_arm at lakedaemon.net:
> > From: Jason Cooper <linux_arm@lakedaemon.net>
> > This is an RFC patch series until mach-types is updated.  This compiles,
> > loads, runs, and sees the SPI flash.
> 
> in case no one else reply to your patch. I wanted to submit a patch, which 
> adds support for the LS-XHL, based on kirkwood, too. Old-fashioned machine 
> support files won't be accepted anymore. Instead you would have to submit a 
> DTS once the kirkwood arch has support for device trees.
> 
Ahhh, that's the key word I was missing.  :-)  I had been reading up on
the arch/arm/* cleanup, and saw that SoC drivers should go in drivers/,
but had missed the DTS bit.

Off to read...

thx,

Jason.
