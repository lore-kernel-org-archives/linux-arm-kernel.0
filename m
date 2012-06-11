From: ceh@ti.com (Hernandez, Carlos)
Date: Mon, 11 Jun 2012 14:21:22 +0000
Subject: Current state of AM33xx patches
In-Reply-To: <CBFB6F19.95320%jkridner@gmail.com>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com>
Message-ID: <32B5D12402BE454796026F6AC58AA86E2E5AF47A@DLEE09.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Jason Kridner [mailto:jkridner at gmail.com]
> Sent: Monday, June 11, 2012 9:51 AM
> To: Daniel Mack; Tony Lindgren; Hilman, Kevin; Paul Walmsley; Hiremath,
> Vaibhav; Hernandez, Carlos; Maupin, Chase
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Kridner, Jason
> Subject: Re: Current state of AM33xx patches
> 
> From: Daniel Mack <zonque@gmail.com>
> >Hey,
> >
> >can anybody give me a quick wrap-up about the current state of AM33xx
> >based SoCs in mainline? What are the next steps to get things merged?
> 
> There is a wiki page [1] that is intended to provide a summary, but I'm
> confident it is not up-to-date.  There is also some automated testing, but
> I'm not aware if any of the test results are public and I believe the
> coverage is fairly limited.  Hopefully Carlos can chime in with any
> information about that.
> 

Linux Nightly Test results are available at http://arago-project.org/testresults/linux/
Builds are currently failing due to wpa-supplicant recipe. 

The current nightly test plan includes: USB Host tests, PWM, Alsa, SPI, MMC, NAND, EDMA, Ethernet, RTC, I2C, PWM, WDT, CPUFREQ,  Timers, Kernel IPC, Math library, LMBench and cyclictest. Let us know if you want other areas to be included in the nightly test plan.
For a sample test coverage, check build from last week at
http://arago-project.org/testresults/linux/ti-staging/2012-06-05_16-05-17/am335x-evm/test-log.html

Carlos

> [1]
> http://processors.wiki.ti.com/index.php/Sitara_Linux_Upstream_Status#AM335
> x
> _Status
> 
> 
> >
> >I'm getting involved in a project that is based on a AM3352 and would
> >like to provide help where necessary and wanted.
> 
> Your help is really appreciated, so thanks in advance.  Hopefully Vaibhav
> or Chase can reply with info about any particular subsystems that need
> either review or coding.  Conversion to Device Tree is an on-going complex
> area where Vaibhav is contributing.
> 
> >
> >
> >Thanks,
> >Daniel
> 
