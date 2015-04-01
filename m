From: robherring2@gmail.com (Rob Herring)
Date: Wed, 1 Apr 2015 11:43:39 -0500
Subject: [PATCH 0/7] OPP: Introduce OPP bindings V2 and supporting code
In-Reply-To: <CAKohpokDhHo1ftcB6b4b+hO125_sqjK0NKESt79GVcWEwiq04w@mail.gmail.com>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
 <CAKohpokDhHo1ftcB6b4b+hO125_sqjK0NKESt79GVcWEwiq04w@mail.gmail.com>
Message-ID: <CAL_JsqLCjkrb2gT-_hj-UTAs+qn2LZtEm=f_C05ovhdwkZKB-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 1, 2015 at 1:22 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 11 February 2015 at 13:46, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Now that I have received an verbal Ack from Rob Herring (in a personal
>> conversation) about the bindings, I am showing how the code looks like with
>> these new bindings.

I have also told you multiple times I want to see others' inputs and
acks. So yes it looks fine to me, but I am not a user of it.

>> Some part is still now done:
>> - Interface for adding new detailed OPPs from platform code instead of DT
>> - Providing cpufreq helpers for the next OPPs
>> - Providing regulator helpers for the target/min/max ranges
>>
>> Please provide feedback on how this looks like..
>
> @Rafael: Its been two months now since this was posted. Can we get this
> merged please? If someone finds issues later, we can go fix them ..

If there are users waiting for this, then get their acks first. As you
already know, I spoke to Stephen at ELC and he still has concerns
about it. As Qualcomm is probably the most complicated case, it needs
to work for them (or we accept that it can't and they do everything
their own way).

Rob
