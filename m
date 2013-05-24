From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 May 2013 13:31:05 +0100
Subject: [GIT PULL] arm-soc: Xilinx zynq core - smp for v3.10
In-Reply-To: <744356bb-78fa-4592-97ef-0709fe65dbee@CH1EHSMHS025.ehs.local>
References: <890ef3b8-f536-4b00-9bd8-5ea50de3bf51@DB8EHSMHS032.ehs.local>
 <20130524112610.GX18614@n2100.arm.linux.org.uk>
 <744356bb-78fa-4592-97ef-0709fe65dbee@CH1EHSMHS025.ehs.local>
Message-ID: <20130524123105.GZ18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 02:10:32PM +0200, Michal Simek wrote:
> Hi Russell,
> 
> On 05/24/2013 01:26 PM, Russell King - ARM Linux wrote:
> > You might want to resolve this new warning:
> > 
> > arch/arm/mach-zynq/hotplug.c:1:0: warning: switch -mcpu=cortex-a9 conflicts with -march= switch
> > 
> > found by lastnights OMAP4430 randconfig build.
> 
> Do you have that randconfig file?
> And can you please point me to the repo which is is used for this build?

Everything which is public is at:

http://www.home.arm.linux.org.uk/developer/build/

I don't make the build tree available because it changes too often and
I don't want _anyone_ to make the mistake of assuming that anything
which is in there is stable.  However, the above URL tells you how it's
generated.  As it is mainline+arm-soc+my tree (including some bits I'm
not publishing), it's pretty much publically available anyway.
