From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Feb 2014 22:04:08 -0700
Subject: [patch] initial perf_event support for Raspberry-Pi
In-Reply-To: <alpine.DEB.2.10.1312311649530.3173@vincent-weaver-1.um.maine.edu>
References: <alpine.DEB.2.10.1312311649530.3173@vincent-weaver-1.um.maine.edu>
Message-ID: <52FB00C8.3050301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31/2013 02:54 PM, Vince Weaver wrote:
> 
> The following patch enables performance counter support on Raspberry-Pi.
> 
> We have this working on the 2708 based rasp-pi kernels by manually putting
> the device registration in the platform files.
> 
> This change does things properly in a device tree.  The boot messages look 
> proper, but my rasp-pi hangs somewhere in USB enabling when running a 
> stock 3.13-rc6 kernel so I have been unable to fully test this change.
> 
> I also understand that the rasp-pi 1176 pmu support is missing the 
> overflow interrupt.  I'm not sure if that's true of all 2835 
> implementations.  If not, then this patch will need to be changed a bit.

I've applied this to bcm2835's for-3.15/dt branch, with minor fixes.
