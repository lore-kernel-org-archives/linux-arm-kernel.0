From: nm@ti.com (Nishanth Menon)
Date: Fri, 7 Feb 2014 13:41:04 -0600
Subject: [PATCH v2 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
In-Reply-To: <52F51FCD.5000009@arm.com>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>
 <1391786342-11812-3-git-send-email-thomas.ab@samsung.com>
 <52F50698.4060305@arm.com> <52F509BD.70903@arm.com>
 <CAGo_u6raZY0sKdDn4d92SKpi=eqUpf23vW8K_bEi-v62V2jdPA@mail.gmail.com>
 <52F51888.5010608@arm.com>
 <CAGo_u6ofC4NNPiTNcSnXUvT3RZJo54=XyjetR-ok5hCBrVZkKg@mail.gmail.com>
 <52F51FCD.5000009@arm.com>
Message-ID: <CAGo_u6quxExJOyY8mvCw5sDSuz=_j0YqJ6FJW+FAdaxUeqzN9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 7, 2014 at 12:02 PM, Sudeep Holla <Sudeep.Holla@arm.com> wrote:
> On 07/02/14 17:37, Nishanth Menon wrote:
>> On Fri, Feb 7, 2014 at 11:31 AM, Sudeep Holla <Sudeep.Holla@arm.com> wrote:
>
> [...]
>
>>> Yes I think its counter-intuitive as it's visible to the userspace(list of
>>> frequencies and the boost parameters are exposed through sysfs)
>>
>> That will be a different problem -> as currently every single
>> frequency in the cpufreq list has ability to be marked as boost
>> frequency - if userspace does not maintain that, then, IMHO, fix the
>> userspace :D
>>
>
> /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies gives
> the list of frequencies based on the state of the boost feature at anytime.
>
> Intuitively the list without boost shouldn't have any frequency above the range
> when it's enabled :), that's what I was referring to. So I am not talking about
> any issue with user-space maintenance.
Fair enough - but i still think it has nothing to do with dt binding
itself -> and i think the discussion we've had should be good for the
binding provided in this patch.. I hope.. if documentation needs a bit
of better explanation to prevent a repeat of the same discussion at a
later point of time, now might be a good time to add it in.

Regards,
Nishanth Menon
