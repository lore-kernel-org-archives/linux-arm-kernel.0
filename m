From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 19:00:52 +0530
Subject: [PATCH 063/228] cpufreq: dbx500: Use generic cpufreq routines
In-Reply-To: <CACRpkdbgpuuSpHpu2-pEvOjd3hB-cqn62Ui6__VFbyNHDLu6+g@mail.gmail.com>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <a3970f9a04fd061a7ad476f983e10a8768c89fd0.1379063063.git.viresh.kumar@linaro.org>
 <CACRpkdbgpuuSpHpu2-pEvOjd3hB-cqn62Ui6__VFbyNHDLu6+g@mail.gmail.com>
Message-ID: <CAKohpomO17L-fX9+vCh-6yMDxULpZ6R+NeR3_QaUG1uoXm2z7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2013 18:48, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Sep 13, 2013 at 3:00 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
>> Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
>> and .attr. So its better if we have generic routines for them which can be used
>> by cpufreq drivers then.
>>
>> This patch uses these generic routines for this driver.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Acked-by. It feels like I acked this before...

Nah, I checked it again :)

Btw, for a second I had my heart in my mouth..
I thought its Torvalds and he will blast me off :)

Thank god, its you :)
