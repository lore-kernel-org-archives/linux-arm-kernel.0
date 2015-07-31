From: slash.tmp@free.fr (Mason)
Date: Fri, 31 Jul 2015 16:54:00 +0200
Subject: Converting "board file" to device tree one device at a time?
In-Reply-To: <55BB4686.8030509@free.fr>
References: <55BB4686.8030509@free.fr>
Message-ID: <55BB8C08.1060006@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/2015 11:57, Mason wrote:

> Then I set a breakpoint in of_platform_serial_probe, hoping
> to witness the miracle... and nothing. Looks like device is
> never registered :-(

IIUC, the kernel is supposed to parse my "uart0" node, and
register the device. Then the platform framework should see
that the node's "compatible" property is equal to one
advertized by the of_platform_serial_driver, and the kernel
should #!@& call of_platform_serial_probe? Right?!

I just can't believe how much time I've been pulling my hair
over this trivial issue...

Regards.
