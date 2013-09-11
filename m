From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Wed, 11 Sep 2013 09:55:46 +0100
Subject: [PATCH 1/4] cpufreq: cpufreq-cpu0: assign cpu_dev correctly to
 cpu0 device
In-Reply-To: <CAKohpokgVqmjNGTUOg61YQyqi1qO-9FaB8dmZqTqq2nQFynOkQ@mail.gmail.com>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1378835989-19281-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <Pine.LNX.4.64.1309111005310.26942@axis700.grange>
 <CAKohpokgVqmjNGTUOg61YQyqi1qO-9FaB8dmZqTqq2nQFynOkQ@mail.gmail.com>
Message-ID: <52303012.3060709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/13 09:42, Viresh Kumar wrote:
> On 11 September 2013 13:45, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
>> Noone else seems to complain, but I don't think these =20, =09 etc. codes
>> have been invented on my side and I don't think they belong here. I'm
>> handling enough mails / patches daily to believe, that my mail system
>> isn't the cause of this. Could you please verify and regenerate and
>> resend? Unless I'm mistaken this looks like a corruption on your SMTP
>> side.
> 
> Its on Sudeep's side :) .. Or on ARM's side..
> Don't know why nobody else complained, Atleast people who test these
> patches (Like Shawn), must have applied them from mail.. Don't know
> why they aren't shouting :)
> 
> He mostly send pull requests to Rafael and so this wasn't a issue for
> Rafael :)
> 

Yes looks like its at my end. I will try to fix it. There is alternate
SMTP which should not have this issue, but it was down recently. I
forgot to switch back to it once it was fixed.

For now you can fetch it from:
	git://linux-arm.org/linux-skn.git cpufreq_fixes_v3.12

Regards,
Sudeep
