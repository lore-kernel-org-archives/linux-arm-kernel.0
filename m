From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 23 May 2014 16:52:19 +0200
Subject: [PATCH] cpufreq: exynos: Fix driver compilation with
 ARCH_MULTIPLATFORM
In-Reply-To: <CAKohpomrv77TE=eH5jiN8YuhhaDZtg0B20GmbWB2ryHcYSwKNg@mail.gmail.com>
References: <537C6350.2010707@gmail.com>
 <1400670752-673-1-git-send-email-t.figa@samsung.com>
 <7243145.22RNvZMdch@wuerfel> <537C9B81.5040301@samsung.com>
 <CAJuA9ajHAyB6eLe0nQiNcCAS1ojG7W+FTJ1EH62H3Ch-DP2bcw@mail.gmail.com>
 <036901cf74f9$0562e640$1028b2c0$@samsung.com>
 <CAKohpomrv77TE=eH5jiN8YuhhaDZtg0B20GmbWB2ryHcYSwKNg@mail.gmail.com>
Message-ID: <537F60A3.6010808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.05.2014 16:05, Viresh Kumar wrote:
> On 21 May 2014 19:01, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> If there is no comments more on Thomas P Abraham's series v4 ;-), I will take that series in this time with ack from Viresh.
> 
> @Thomas: Please post V5 quickly, let close it ASAP :)
> 

Well, as far as I can see, the DT binding is not yet acked by DT
maintainers, so IMHO the best solution for this release would be to
apply my patch to avoid regression. New version with some of Viresh's
comments addressed is on the way.

Best regards,
Tomasz
