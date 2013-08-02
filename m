From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 2 Aug 2013 17:06:02 -0400
Subject: [PATCH] WIP: HACK: LPAE, BOOTMEM and NO_BOOTMEM
In-Reply-To: <20130726030812.GB30195@mtj.dyndns.org>
References: <20130629152959.GB31339@mtj.dyndns.org>
 <20130629172123.GA3353@n2100.arm.linux.org.uk>
 <20130629175743.GA382@mtj.dyndns.org>
 <CAE9FiQXHuP-n0eZ9wN73V4nSvE+XEExDsx1t50_=YaW+V=LGLg@mail.gmail.com>
 <20130629195549.GE3353@n2100.arm.linux.org.uk>
 <CAE9FiQUoVNvWmmTV2+ZkU_nMxFToTHw6QLwp_Z_EjwMzqdLwuA@mail.gmail.com>
 <51D18DBA.6090608@ti.com> <51F1A7AA.8080700@ti.com>
 <20130725223658.GJ26107@mtj.dyndns.org> <51F1B17F.30902@ti.com>
 <20130726030812.GB30195@mtj.dyndns.org>
Message-ID: <51FC1F3A.8090201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tejun,

On Thursday 25 July 2013 11:08 PM, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jul 25, 2013 at 07:15:11PM -0400, Santosh Shilimkar wrote:
>> Sorry if I wasn't clear before, but I need help to at least have new
>> memblock API support since I am not familiar with memblock code. 
>> I could help in adaptation to the new API for ARM arch and
>> core kernel code.
>>
>> Let me know your thoughts.
> 
> Unfortunately, I'm currently a bit too occupied to work on it myself.
> Any volunteers?
> 
Looking at the situation, how about proceeding with patch updating
the bootmem API signatures to use phys_addr_t  which can unblock me
to get my machine working.

Introduction of new API, conversions of core kernel code and then
arches moving away from bootmem is going to take significant time
anyways. I will continue my effort to get ARM port moved to no-bootmem
and get that merged.

Let me know how to make progress here. Appreciate your help on the subject.

Regards,
Santosh
