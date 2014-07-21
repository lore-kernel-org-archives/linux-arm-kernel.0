From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 21 Jul 2014 09:40:32 -0400
Subject: [RFC] cpufreq: Add bindings for CPU clock sharing topology
In-Reply-To: <CAKohpok-C+JCebjJkZExx6EjBctoyJF7fV71Vjj7bi1TAdXrFQ@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>	<CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>	<CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>	<CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>	<CAKohpokLqrydV3b=innvOWrW9ijXtZwPKdT5Ew65cjMxsY2Mvw@mail.gmail.com>	<53CA8D95.8010108@ti.com>
 <CAKohpok-C+JCebjJkZExx6EjBctoyJF7fV71Vjj7bi1TAdXrFQ@mail.gmail.com>
Message-ID: <53CD1850.8000904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 20 July 2014 08:07 AM, Viresh Kumar wrote:
> On 19 July 2014 20:54, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>> Sorry for jumping late
> 
> No, you aren't late. Its just 2 days old thread :)
> 
>> but one of the point I was raising as part of your
>> other series was to extend the CPU topology bindings to cover the voltage
>> domain information which is probably what is really needed to let the
>> CPUfreq extract the information. Not sure if it was already discussed.
> 
> Not it wasn't.
> 
>> After all the CPU clocks, cluster, clock-gating, power domains are pretty much
>> related. So instead of having new binding for CPUFreq, I was wondering whether
>> we can extend the CPU topology binding information to include missing information.
>> Scheduler work anyway needs that information.
>>
>> Ref: Documentation/devicetree/bindings/arm/topology.txt
>>
>> Does that make sense ?
> 
> Yeah it does, but I am not sure what exactly the bindings should look then.
> So, the most basic step could be moving the new bindings to topology.txt
> and name clock-master to dvfs-master.
> 
> What else?
> 
> If its going to be much controversial then we *can* go for just dvfs bindings
> for now and then update them later.
> 
Would be good to get others opinion. As you said if it is controversial then
it will stall the development.

Regards,
Santosh
