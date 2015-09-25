From: menon.nishanth@gmail.com (Nishanth Menon)
Date: Fri, 25 Sep 2015 12:38:39 -0500
Subject: [PATCH 1/3] Documentation: dt: keystone: provide SoC specific
 compatible flags
In-Reply-To: <56057319.9080104@oracle.com>
References: <1442938118-4718-1-git-send-email-nm@ti.com>
 <1442938118-4718-2-git-send-email-nm@ti.com> <5602ED34.9010108@oracle.com>
 <56040323.1080409@ti.com> <560406C2.6090200@ti.com> <56041CA4.40208@ti.com>
 <56055F1F.4060401@ti.com> <560565AF.2010701@oracle.com>
 <56056FD9.5060000@ti.com> <56057319.9080104@oracle.com>
Message-ID: <5605869F.9080906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2015 11:15 AM, santosh shilimkar wrote:
> 9/25/2015 9:01 AM, Nishanth Menon wrote:
>> On 09/25/2015 10:18 AM, santosh shilimkar wrote:
>>> On 9/25/2015 7:50 AM, Nishanth Menon wrote:
>> [...]
>>>> But, how about userspace
>>>> needing to know which SoC they are on, without needing to depend on
>>>> board->soc mapping? How do we help resolve that?
>>>>
>>> Why the user space should care about exact SOC ?
>>
>> examples vary - trivial one is: debug tools like omapconf[1] or testing
>> tools like opentest[2] need some standard way to ensure Linux kernel is
>> functional - trusting the least set of parameters is usually what we
>> would prefer. while building a generic distro such as debian or yocto,
>> one prefers NOT to need to do a package build per SoC/perboard - that
>> never scales. instead, you'd like the same application run on different
>> systems dynamically.
>>
> I guessed omapconf example is coming though Keystone has no such tool

:) That is true - as of now. maynot be the case for future.

> yet ;-). Opentest shouldn't need that info either.

we did debate this on opentest, but we could not implement anything
since we did not have a consistent solution yet.

> I do agree that having a soc along with board is useful in
> longer run to accommodation more boards and variants.
> And only on that merit, I am willing to take these patches.
> 
> Please refresh the series commit messages based on the
> discussion so far and repost. Will pick it up then.
> 
Thanks. I will do so (probably early next week)..


-- 
Regards,
Nishanth Menon
