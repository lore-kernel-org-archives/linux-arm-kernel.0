From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Sep 2010 20:08:48 +0100
Subject: linux-2.6.36-rc4 problems booting rootfs from SD card
In-Reply-To: <20100928130043.000074b1@unknown>
References: <20100928130043.000074b1@unknown>
Message-ID: <20100928190848.GA8649@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 28, 2010 at 01:00:43PM +0200, dylan cristiani wrote:
> Hi sirs, here is my scenario: kernel 2.6.36-rc4; cpu pxa270; platform
> is an enhancement (i like to see things that way...) and customisation
> of the mainstone III board; here comes the (my) problem: if i boot with
> my standard kernel boot command line (to boot from system flash):
> 'root=/dev/mtdblock2 rootfstype=jffs2 mem=64M console=ttyS0,115200n8'
> 
> i can get the rootfs up, and the SD card is up too, and correctly
> working; here's the relevant kernel log:

Use 'rootdelay=1' to give time for the SD card to be detected.
