From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jul 2016 09:49:25 +0100
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <7352796.seiSnHrYPy@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <5352106.oQ0Ff9gWJA@wuerfel> <20160713094127.GC14522@leverpostej>
 <7352796.seiSnHrYPy@wuerfel>
Message-ID: <20160715084925.GD1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 03:13:42PM +0200, Arnd Bergmann wrote:
> On Wednesday, July 13, 2016 10:41:28 AM CEST Mark Rutland wrote:
> > The big question is whether this is a realistic case on a secure boot
> > system.
> 
> What does x86 do here? I assume changes to the command line are also
> limited.

They aren't.  You can specify /anything/ even with a fully-signed kernel
and initrd, which was one of the things I pointed out in my previous
set of responses.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
