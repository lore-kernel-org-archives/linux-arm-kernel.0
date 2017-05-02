From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 2 May 2017 17:43:02 +0100
Subject: [PATCH 1/1] arm64: Always provide "model name" in /proc/cpuinfo
In-Reply-To: <15006378-af42-b029-f967-3f7230b64706@gmx.de>
References: <20170501223913.6894-1-xypron.glpk@gmx.de>
 <20170502110827.GA29224@e104818-lin.cambridge.arm.com>
 <15006378-af42-b029-f967-3f7230b64706@gmx.de>
Message-ID: <b48e8346-f7b4-1f2f-082a-572864c415a8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/05/17 17:28, Heinrich Schuchardt wrote:
[...]

> The real interesting thing in an ARM SOC is to see which CPU is A72,
> A57, A53 or whatever.
> 
> This information is available from the device tree in the compatible
> property of the individual CPUs
> (/sys/firmware/devicetree/base/cpus/cpu@*/compatible), e.g.
> compatible =3D "arm,cortex-a53", "arm,armv8";
> 

You can refer "CPU part" in /proc/cpuinfo for the above information.

-- 
Regards,
Sudeep
