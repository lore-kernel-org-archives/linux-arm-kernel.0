From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Sep 2010 11:09:10 +0100
Subject: Maximum bootable kernel size in current ARM linux
In-Reply-To: <20100916175127.GA27467@n2100.arm.linux.org.uk>
References: <4C8DD588.7040009@endruntechnologies.com>
	<201009131043.48688.marek.vasut@gmail.com>
	<AANLkTimti4ajAOR0_aZ8aeGu9PN4a0MX8dbpg6dpZJYf@mail.gmail.com>
	<20100913101039.GC2614@kw.sim.vm.gnt>
	<000001cb5409$4726e000$4b4d010a@Emea.Arm.com>
	<1284468849.933.2.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1009141333090.19366@xanadu.home>
	<1284657411.32513.3.camel@e102109-lin.cambridge.arm.com>
	<20100916175127.GA27467@n2100.arm.linux.org.uk>
Message-ID: <1284718150.22217.10.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-16 at 18:51 +0100, Russell King - ARM Linux wrote:
> I think we're better of staying as we are - thereby keeping the performance
> for the majority use case, and telling those few people who want a massive
> kernel binary not to do that.  In the case of a large initramfs, pass it
> in as an initrd, possibly using the bootp stuff I've mentioned previously
> if you want a single self-contained image.

You can also create a big blob containing kernel and filesystem with
something like this (adapted for one's needs):

http://linux-arm.org/LinuxReference/RunningOnModel

-- 
Catalin
