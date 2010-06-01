From: bbb.lst@gmail.com (Bjoern Brandenburg)
Date: Tue, 1 Jun 2010 18:57:24 -0400
Subject: 2.6.34 hangs during boot on PB11MPCore
In-Reply-To: <F01D8B85CFF58440B2A13965FBA90CA42DA38528B5@GEORGE.Emea.Arm.com>
References: <AANLkTin9n6HDdiTnQoQ9mrmuzSR8JhZVq7uPgU86yqgU@mail.gmail.com>
	<20100530073652.GX2695@buzzloop.caiaq.de>
	<AANLkTimUF5iiGnc6RnN5C3sy-R6DAqHZNf6ZEu2o3W9P@mail.gmail.com>
	<AANLkTikdvjg52v-3AKUBukGO2FCp3fENGoYgpZZ2xVtT@mail.gmail.com>
	<AANLkTilMtEpt5hRfF_hszpU_AxZm7H93bkhqUacGWZc9@mail.gmail.com>
	<1275259589.22752.14.camel@e102109-lin.cambridge.arm.com>
	<AANLkTim4e5Sdj9tronOiI-sIMVGaUQdfRIhKHzZ4XfKp@mail.gmail.com>
	<AANLkTim3YdK3QDXC-20otTBPqYF_XX9rGHRX50cycqk6@mail.gmail.com>
	<1275290414.2843.11.camel@e102109-lin.cambridge.arm.com>
	<F01D8B85CFF58440B2A13965FBA90CA42DA38528B5@GEORGE.Emea.Arm.com>
Message-ID: <AANLkTinvXEs9UKl1hEW8zf2t7JqylO4zhocRfEpak1ho@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 1, 2010 at 3:46 AM, Colin Tuckley <Colin.Tuckley@arm.com> wrote:
>> -----Original Message-----
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
>> kernel-bounces at lists.infradead.org] On Behalf Of Catalin Marinas
>
>> Regarding the SMSC 911x driver synchronisation - I've been asking SMSC
>> for more than a year to look into this.
>
> I'm still waiting for them to take up our offer of a PB11MPCore system for testing.
>
> One thing Bjoern hasn't mentioned... is the board firmware up to date? I.e. has the fpga image been updated to the latest release (from the latest CD).
>

Mhhh... Despite much looking through the arm.com site, I couldn't
figure out what the "latest CD" is. We got our box last September and
haven't installed any firmware updates since. Thus it's quite possible
that the firmware is out of date.
Is this the revision ID that you're looking for?

# cat /proc/cpuinfo
Processor	: ARMv6-compatible processor rev 0 (v6l)
processor	: 0
BogoMIPS	: 83.55

processor	: 1
BogoMIPS	: 83.55

processor	: 2
BogoMIPS	: 83.55

processor	: 3
BogoMIPS	: 83.55

Features	: swp half thumb fastmult vfp edsp java
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xb02
CPU revision	: 0

Hardware	: ARM-RealView PB11MPCore
Revision	: 2159f503
Serial		: 0000000000000000

- Bj?rn
