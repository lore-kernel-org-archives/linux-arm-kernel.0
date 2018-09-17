From: keescook@chromium.org (Kees Cook)
Date: Mon, 17 Sep 2018 07:54:49 -0700
Subject: [PATCH 2/6] pstore: Add event tracing support
In-Reply-To: <CAEXW_YSPNqVgoYWjVAMvGg_WoRV4SC2xDH1wQWTdQfBUOMQbbQ@mail.gmail.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <141901b8-0a9a-2e7a-f7a4-cdefd157f4c6@codeaurora.org>
 <CAEXW_YSPNqVgoYWjVAMvGg_WoRV4SC2xDH1wQWTdQfBUOMQbbQ@mail.gmail.com>
Message-ID: <CAGXu5jLkE+mZkVSFPeOq75im0Kozm+NzfqL9CD-OMe7b7=3O5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 16, 2018 at 6:55 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Sun, Sep 16, 2018, 12:08 AM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>>
>> On 9/9/2018 1:57 AM, Sai Prakash Ranjan wrote:
>> > Currently pstore has function trace support which can be
>> > used to get the function call chain with limited data.
>> > Event tracing has extra data which is useful to debug wide
>> > variety of issues and is heavily used across the kernel.
>> >
>> > Adding this support to pstore can be very helpful to debug
>> > different subsystems since almost all of them have trace
>> > events already available. And also it is useful to debug
>> > unknown resets or crashes since we can get lot more info
>> > from event tracing by viewing the last occurred events.
>>
>> Anyone here?
>
> Sorry for the top post. I've been wanting to do this as well for some time.
> It's quite useful. I am out of office this week and away from work machine.
> I will take a look at your patches next week once I'm back at work. Thanks.

If Steven agrees this shouldn't live in ftrace directly and Joel
reviews these patches, I think it should be fine. I'm travelling, but
I can review it hopefully later this week.

-Kees

-- 
Kees Cook
Pixel Security
