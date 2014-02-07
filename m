From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Fri, 07 Feb 2014 18:02:53 +0000
Subject: [PATCH v2 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
In-Reply-To: <CAGo_u6ofC4NNPiTNcSnXUvT3RZJo54=XyjetR-ok5hCBrVZkKg@mail.gmail.com>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>	<1391786342-11812-3-git-send-email-thomas.ab@samsung.com>	<52F50698.4060305@arm.com>	<52F509BD.70903@arm.com>	<CAGo_u6raZY0sKdDn4d92SKpi=eqUpf23vW8K_bEi-v62V2jdPA@mail.gmail.com>	<52F51888.5010608@arm.com>
 <CAGo_u6ofC4NNPiTNcSnXUvT3RZJo54=XyjetR-ok5hCBrVZkKg@mail.gmail.com>
Message-ID: <52F51FCD.5000009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/14 17:37, Nishanth Menon wrote:
> On Fri, Feb 7, 2014 at 11:31 AM, Sudeep Holla <Sudeep.Holla@arm.com> wrote:

[...]

>> Yes I think its counter-intuitive as it's visible to the userspace(list of
>> frequencies and the boost parameters are exposed through sysfs)
> 
> That will be a different problem -> as currently every single
> frequency in the cpufreq list has ability to be marked as boost
> frequency - if userspace does not maintain that, then, IMHO, fix the
> userspace :D
> 

/sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies gives
the list of frequencies based on the state of the boost feature at anytime.

Intuitively the list without boost shouldn't have any frequency above the range
when it's enabled :), that's what I was referring to. So I am not talking about
any issue with user-space maintenance.

Regards,
Sudeep
