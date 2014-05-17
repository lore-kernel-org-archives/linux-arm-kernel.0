From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 17 May 2014 02:40:07 +0200
Subject: [PATCH v4 0/4] Adds PMU and S2R support for exynos5420
In-Reply-To: <CAM4voan82jypoHTOo9KwsvA7tPzdYYa3QYNHMo4Q2Yvt_cf7gA@mail.gmail.com>
References: <1399982522-27928-1-git-send-email-a.kesavan@samsung.com>	<53753021.5050801@gmail.com>
 <CAM4voan82jypoHTOo9KwsvA7tPzdYYa3QYNHMo4Q2Yvt_cf7gA@mail.gmail.com>
Message-ID: <5376AFE7.9030406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.05.2014 07:07, Abhilash Kesavan wrote:
> Hi Tomasz,
> 
> On Fri, May 16, 2014 at 2:52 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi Abhilash,
>>
>> On 13.05.2014 14:01, Abhilash Kesavan wrote:
>>> Rebased on
>>> 1] Kukjin Kim's tree for-next branch (which has Sachin Kamat's SYSRAM
>>> patches merged) with Tomasz Figa's samsung clock tree (samsung-next branch)
>>> merged.
>>> https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
>>> 2] Pankaj Dubey's v4 PMU patchset
>>> https://lkml.org/lkml/2014/5/10/29
>>
>> I think this patch is not safe to base on yet. I need to find time to
>> review the latest version and share my latest view on this with Pankaj,
>> as I have a bit different design in mind.
> OK, do you think the PMU series might make it this cycle or should I
> drop this as a dependency and re-base my patches just on Daniel's
> CPUIdle consolidation.

I'd say it's too late for 3.16 already, for the PMU series at least.
3.15-rc6 will probably show up in next days and Kukjin still has to send
pull requests to ARM-SoC, so I'd defer this series for 3.17 as well,
especially considering the fact that extending the PMU code in its
current form already met with opposition.

Best regards,
Tomasz
