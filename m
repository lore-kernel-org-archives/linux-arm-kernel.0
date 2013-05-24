From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 May 2013 12:26:10 +0100
Subject: [GIT PULL] arm-soc: Xilinx zynq core - smp for v3.10
In-Reply-To: <890ef3b8-f536-4b00-9bd8-5ea50de3bf51@DB8EHSMHS032.ehs.local>
References: <890ef3b8-f536-4b00-9bd8-5ea50de3bf51@DB8EHSMHS032.ehs.local>
Message-ID: <20130524112610.GX18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 09:47:09AM +0200, Michal Simek wrote:
> Hi Arnd and Olof,
>
> please pull the following smp support to your arm-soc tree.
>
> This branch is based on zynq/clksrc/cleanup parts because
> there are some dependencies on moving timer to generic location.
>
> I could based it on standard Linux tagged version but you will get
> several conflicts you will have to resolve.
> If you are OK to resolving these problems, please let me know
> I will create another branch with core-smp changes which are not based
> on zynq/clksrc/cleanup branch.

You might want to resolve this new warning:

arch/arm/mach-zynq/hotplug.c:1:0: warning: switch -mcpu=cortex-a9 conflicts with -march= switch

found by lastnights OMAP4430 randconfig build.
