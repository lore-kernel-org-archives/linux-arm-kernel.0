From: sudeepholla.maillist@gmail.com (Sudeep K N)
Date: Tue, 27 Nov 2012 11:19:49 +0000
Subject: [PATCH] cpufreq: SPEAr: Add CPUFreq driver
In-Reply-To: <CAKohponbWUTtxMBLTGaRTmQX4WArtHAt9KzAnqF2OtQpf46osg@mail.gmail.com>
References: <7ec0e3f4b81b70f3def4257e6b9781efd4c7a3d2.1353785862.git.viresh.kumar@linaro.org>
 <CAPKp9uZ-HpAp2KO9qKXsMCoGJS3Vn-VW34h6cbv8o01Vzzi4jw@mail.gmail.com>
 <CAKohponbWUTtxMBLTGaRTmQX4WArtHAt9KzAnqF2OtQpf46osg@mail.gmail.com>
Message-ID: <CAPKp9uZY022gdbRYs-a87xb4nnStOWUDQtS=_nJe0p7KTgvFKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 9:33 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27 November 2012 14:54, Sudeep K N <sudeepholla.maillist@gmail.com> wrote:
>> On Sat, Nov 24, 2012 at 7:39 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> [...]
>>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-spear.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-spear.txt
>>> new file mode 100644
>>> index 0000000..4cf2819
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-spear.txt
>>> @@ -0,0 +1,29 @@
>>> +SPEAr cpufreq driver
>>> +-------------------
>>> +
>>> +SPEAr SoC cpufreq driver for CPU frequency scaling.
>>> +It supports both uniprocessor (UP) and symmetric multiprocessor (SMP) systems
>>> +which share clock across all CPUs.
>>
>> If this is the case, is there any particular reason why you cannot use
>> the generic
>> cpufreq-cpu0 driver ?
>
> Please go through the discussion already done with Shawn. There is lot of
> SPEAr specific code here.
>

Sorry I missed the fact that there are more patches, I based my commit
on clock related changes in current patch.

-- 
Regards,
Sudeep
