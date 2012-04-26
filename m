From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Apr 2012 20:11:59 +0100
Subject: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
In-Reply-To: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20120426191159.GA9415@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 11:10:31PM +0530, Keerthy wrote:
> From: J Keerthy <j-keerthy@ti.com>
> 
> AVS(Adaptive Voltage Scaling) is a power management technique which
> controls the operating voltage of a device in order to optimize (i.e. reduce)
> its power consumption. The voltage is adapted depending on static factors
> (chip manufacturing process) and dynamic factors (temperature
> depending performance).
> The TI AVS solution is named Smartreflex. 

What's the relationship between this and existing things like devfreq
and cpufreq?  It'd be better if the changelogs made this clear and
provided an overview of how all these different subsystems are intended
to fit together.
