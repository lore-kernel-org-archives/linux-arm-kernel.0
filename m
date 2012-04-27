From: j-keerthy@ti.com (J, KEERTHY)
Date: Fri, 27 Apr 2012 11:09:10 +0530
Subject: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
In-Reply-To: <20120426191159.GA9415@sirena.org.uk>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
 <20120426191159.GA9415@sirena.org.uk>
Message-ID: <CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On Fri, Apr 27, 2012 at 12:41 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Apr 26, 2012 at 11:10:31PM +0530, Keerthy wrote:
>> From: J Keerthy <j-keerthy@ti.com>
>>
>> AVS(Adaptive Voltage Scaling) is a power management technique which
>> controls the operating voltage of a device in order to optimize (i.e. reduce)
>> its power consumption. The voltage is adapted depending on static factors
>> (chip manufacturing process) and dynamic factors (temperature
>> depending performance).
>> The TI AVS solution is named Smartreflex.
>
> What's the relationship between this and existing things like devfreq
> and cpufreq? ?It'd be better if the changelogs made this clear and
> provided an overview of how all these different subsystems are intended
> to fit together.

Devfreq and cpufreq are related to dynamic frequency/voltage switching between
pre defined Operating Performance Points or the OPPs. Every OPP being
a voltage/frequency pair. Smartreflex is a different
power management technique.

SmartReflex is a technology that uses adaptive
power supply to achieve the goal of reducing active power consumption.
With SmartReflex, the power supply voltage can be adapted to the silicon
performance either statically (for example, adapted to the manufacturing process
of a given device), or dynamically (for example, adapted to the temperature
induced current performance of the device).

So for every OPP(voltage/frequency pair) depending on the silicon process and
temperature the Smartreflex tries to get the voltage to an optimal
value at which
the corresponding frequency can be sustained.

-- 
Regards and Thanks,
Keerthy
