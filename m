From: skannan@codeaurora.org (skannan at codeaurora.org)
Date: Thu, 24 Jul 2014 09:12:13 -0000
Subject: [PATCH] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
In-Reply-To: <CAKohpokynnTttD7Wbq8uBB4SXK9xFEBdRJ2ozhMQscyvq69xRw@mail.gmail.com>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
 <16164926.ZsJxe6UV3e@vostro.rjw.lan> <53D07737.70904@codeaurora.org>
 <CAKohpokynnTttD7Wbq8uBB4SXK9xFEBdRJ2ozhMQscyvq69xRw@mail.gmail.com>
Message-ID: <ca2398ca40725bf3b1b258ab3707970e.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Viresh Kumar wrote:
> On 24 July 2014 08:32, Saravana Kannan <skannan@codeaurora.org> wrote:
>> Ok, I think I've figured this out. But one question. Is it possible to
>> physically remove one CPU in a bunch of "related cpus" without also
>> unplugging the rest? Put another way, can you unplug one core from a
>> cluster?
>
> Are we talking about doing this here:
>
> echo 0 > /sys/devices/system/cpu/cpuX/online      ??
>
> If yes, then what's the confusion all about? Yes we do it all the time.
>

No. That's why I said physically remove.

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
