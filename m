From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 30 Sep 2015 10:31:48 -0400
Subject: [PATCH 1/3] Documentation: dt: keystone: provide SoC specific
 compatible flags
In-Reply-To: <56056FD9.5060000@ti.com>
References: <1442938118-4718-1-git-send-email-nm@ti.com>
 <1442938118-4718-2-git-send-email-nm@ti.com> <5602ED34.9010108@oracle.com>
 <56040323.1080409@ti.com> <560406C2.6090200@ti.com> <56041CA4.40208@ti.com>
 <56055F1F.4060401@ti.com> <560565AF.2010701@oracle.com>
 <56056FD9.5060000@ti.com>
Message-ID: <560BF254.2040509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2015 12:01 PM, Nishanth Menon wrote:
> On 09/25/2015 10:18 AM, santosh shilimkar wrote:
>> On 9/25/2015 7:50 AM, Nishanth Menon wrote:
> [...]
>>> But, how about userspace
>>> needing to know which SoC they are on, without needing to depend on
>>> board->soc mapping? How do we help resolve that?
Believe it or not, user space tools that are custom to a specific SoC 
would require such knowledge. So I agree on this front that a SoC 
specific compatibility is cool to have. I think that should have been 
clear in the commit description.

My Acked-By: Murali Karicheri <m-karicheri2@ti.com>

>>>
>> Why the user space should care about exact SOC ?
>
> examples vary - trivial one is: debug tools like omapconf[1] or testing
> tools like opentest[2] need some standard way to ensure Linux kernel is
> functional - trusting the least set of parameters is usually what we
> would prefer. while building a generic distro such as debian or yocto,
> one prefers NOT to need to do a package build per SoC/perboard - that
> never scales. instead, you'd like the same application run on different
> systems dynamically.
>
>
> [1] https://github.com/omapconf/omapconf
> [2] http://arago-project.org/wiki/index.php/Opentest
>


-- 
Murali Karicheri
Linux Kernel, Keystone
