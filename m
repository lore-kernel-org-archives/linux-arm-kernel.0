From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 29 Jan 2013 16:13:46 -0500
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130129195427.GB30831@schnuecks.de>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
 <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
 <510506F9.3070500@gmail.com>
 <20130128182218.GB9436@obsidianresearch.com>
 <20130128194656.GL1758@titan.lakedaemon.net>
 <20130129195427.GB30831@schnuecks.de>
Message-ID: <20130129211346.GH7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 08:54:27PM +0100, Simon Baatz wrote:
> On Mon, Jan 28, 2013 at 02:46:56PM -0500, Jason Cooper wrote:
> > Simon,
> > 
> > Can you try this in conjunction with enabling ARM_ATAG_DTB_COMPAT ?
> > Does that solve your issue?
> 
> I use
> 
> CONFIG_ARM_ATAG_DTB_COMPAT=y
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
> 
> in my standard configuration already. I don't use the original U-Boot
> that came with the device, but a mainline one which supports my box.

Ahh, I thought you were using the stock bootloader that came with the
device.  Thanks for clearing that up.

thx,

Jason.
