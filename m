From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 15 May 2015 15:31:01 +0530
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <20150515095159.GF2067@n2100.arm.linux.org.uk>
References: <20150512155004.GP2067@n2100.arm.linux.org.uk>
 <555380F8.5050306@free.fr>
 <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
 <5554858A.9010207@free.fr> <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr>
 <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
 <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <5555BC7E.7010601@free.fr>
 <20150515095159.GF2067@n2100.arm.linux.org.uk>
Message-ID: <20150515100101.GJ6348@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-05-15, 10:51, Russell King - ARM Linux wrote:
> As you don't say which kernel version you're using, for all we know, you
> might be using a version which omits some fixes in this area, such as
> this one which you really must have if your timer is operating in
> period mode:
> 
> fe79a9ba1196 clockevents: Adjust timer interval when frequency changes

Atleast the link he gave was for 3.14 and this patch got commited in
3.15 :)

If that's the Mason, this patch is all you need.

-- 
viresh
