From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Jan 2011 12:00:13 +0000
Subject: questions about arm trustzone
In-Reply-To: <bb0c3855a121603232d022b4062752a6@mail.gmail.com>
References: <AANLkTi=eCOiP7MrUSG4WRMN0kj_+ZWvZ=z7VYDfkshU_@mail.gmail.com>
	<8yad3nlh18e.fsf@huya.qualcomm.com>
	<AANLkTin9fSw5DdqdgCEvtdtc83LFOeA7t0OAUugVmRFD@mail.gmail.com>
	<20110125102652.GB11507@n2100.arm.linux.org.uk>
	<bb0c3855a121603232d022b4062752a6@mail.gmail.com>
Message-ID: <20110125120013.GH11507@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 05:16:19PM +0530, Santosh Shilimkar wrote:
> The code above won't give major details of how the monitor mode is
> implemented.  But as Russell said, it's pretty much vendor specific.
> 
> On OMAP, We have standard API interfaces to enter into monitor
> world. One of the parameter denotes the kind of service, is
> requested.

In much the same way as we do with r7 with the kernels userspace syscall
interface via swi/svc.
