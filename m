From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 1 Apr 2015 11:52:50 +0530
Subject: [PATCH 0/7] OPP: Introduce OPP bindings V2 and supporting code
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Message-ID: <CAKohpokDhHo1ftcB6b4b+hO125_sqjK0NKESt79GVcWEwiq04w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 February 2015 at 13:46, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Now that I have received an verbal Ack from Rob Herring (in a personal
> conversation) about the bindings, I am showing how the code looks like with
> these new bindings.
>
> Some part is still now done:
> - Interface for adding new detailed OPPs from platform code instead of DT
> - Providing cpufreq helpers for the next OPPs
> - Providing regulator helpers for the target/min/max ranges
>
> Please provide feedback on how this looks like..

@Rafael: Its been two months now since this was posted. Can we get this
merged please? If someone finds issues later, we can go fix them ..

And this *should* not break any existing stuff as this is mostly new stuff..

--
viresh
