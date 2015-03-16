From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 16 Mar 2015 15:24:20 +0530
Subject: [PATCH 0/7] OPP: Introduce OPP bindings V2 and supporting code
In-Reply-To: <CAKohpokF0_or8aXwzWZ=bUX1Robk8THyqRpKjbaarg9NHufLmw@mail.gmail.com>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
 <CAKohpokF0_or8aXwzWZ=bUX1Robk8THyqRpKjbaarg9NHufLmw@mail.gmail.com>
Message-ID: <CAKohpok1rQFywhgpajomXYu+uc7zmuhVhg0RY4vJzaH2uKNURA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2015 at 10:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 11 February 2015 at 13:46, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Now that I have received an verbal Ack from Rob Herring (in a personal
>> conversation) about the bindings, I am showing how the code looks like with
>> these new bindings.
>>
>> Some part is still now done:
>
> s/now/not
>
>> - Interface for adding new detailed OPPs from platform code instead of DT
>> - Providing cpufreq helpers for the next OPPs
>> - Providing regulator helpers for the target/min/max ranges
>>
>> Please provide feedback on how this looks like..
>
> Can we have some reviews of the code changes please ?

Rob/Rafael/Arnd/Nishanth,

Reviews please? This had been hanging since a long time, can we get this merged
in next merge window please?

Bindings are already OK'd by Rob (in personal conversation) and its
all about code
now. Which can be updated later on as well if we find an issue..

@Rob: Can you please Ack whatever stuff you are okay with ?

--
viresh
