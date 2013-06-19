From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 19 Jun 2013 13:45:12 +0530
Subject: [PATCH V3 01/14] watchdog/mpcore_wdt: Mark it as BROKEN
In-Reply-To: <319bb53672a5fa97b7aa603392b6a2fa@localhost>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
 <22d22fe6eea294c5132e47b8901e094d60b0e99d.1371535242.git.viresh.kumar@linaro.org>
 <20130618154236.GA9022@roeck-us.net> <51C086A8.3070601@arm.com>
 <CAOesGMia0OZz5dcDooRHG9EAnaLimRL5_Gku2rm_fVDNxrxEEA@mail.gmail.com>
 <CAKohpom3S3NMhxbhbmyC6bceS51727CnWRWmWDGxwDcRJkHFyQ@mail.gmail.com>
 <319bb53672a5fa97b7aa603392b6a2fa@localhost>
Message-ID: <CAKohpokUJKt4dcqYpKLNVn2_f7OeZgiftZB3M+aa3-83o_XDcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 June 2013 13:26, Marc Zyngier <marc.zyngier@arm.com> wrote:
> ARM11, A5 and A9 in their MP configurations only.
>
>> If no, then which ones are the real users of this driver/hardware?
>> If yes, Why isn't anybody using this?
>
> Because, as Russell mentioned, the piece of IP doesn't fit our watchdog
> model at all (per-CPU watchdog???), and most SoCs/boards have a separate
> watchdog anyway.

I believe we should use mpcore watchdogs. Atleast on the platforms I have
worked (SPEAr), they don't have an external watchdog.

But yes, this would require somebody, with a A5/9/ARM11 board, no
separate watchdog and a customer requirement, to work on it :)

I will get rid of it.

Thanks.
