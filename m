From: gmbnomis@gmail.com (Simon Baatz)
Date: Tue, 29 Jan 2013 20:54:27 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130128194656.GL1758@titan.lakedaemon.net>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
 <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
 <510506F9.3070500@gmail.com>
 <20130128182218.GB9436@obsidianresearch.com>
 <20130128194656.GL1758@titan.lakedaemon.net>
Message-ID: <20130129195427.GB30831@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 02:46:56PM -0500, Jason Cooper wrote:
> Simon,
> 
> Can you try this in conjunction with enabling ARM_ATAG_DTB_COMPAT ?
> Does that solve your issue?

I use

CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y

in my standard configuration already. I don't use the original U-Boot
that came with the device, but a mainline one which supports my box.

- Simon
