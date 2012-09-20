From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 20 Sep 2012 23:22:09 +0530
Subject: [PATCH V3 0/8] ARM: OMAP4: Add PMU Support
In-Reply-To: <alpine.DEB.2.00.1209201742070.12583@utopia.booyaka.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1209201714260.12583@utopia.booyaka.com>
 <CAMQu2gxdbbfEEGtAGBL5rxUmAPYXgE-Z8Q0mze=NFnrn+3T0QQ@mail.gmail.com>
 <alpine.DEB.2.00.1209201742070.12583@utopia.booyaka.com>
Message-ID: <CAMQu2gx5uwUYW7BTW9Uc3E-q3GRiB0cWxoBbSY-+poDgeiOVfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 11:13 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Thu, 20 Sep 2012, Shilimkar, Santosh wrote:
>
>> On Thu, Sep 20, 2012 at 10:47 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> >
>> > Have queued most of these for 3.7 with the exception of the OMAP4430
>> > CTI-related patches (which look to me like 3.8 material) and the PM
>> > runtime suspend/resume patch (which looks to me like 3.7-rc material) --
>> > assuming this series makes it in for 3.7 ...
>> >
>> Any reason CTI patches can't be taken now. In fact the CTI patches are
>> on the list more time than the other ones.
>
> I listed the reasons briefly here:
>
>    http://marc.info/?l=linux-omap&m=134816037709379&w=2
>
Sorry I should read it before asking the question.

> Let me know if you need more detail.
>
Thats pretty clear.

>> > Apologies in advance if I broke something else in the process.
>> >
>> Perf will remain broken on OMAP4 without CTI patches.
>
> Looks to me that it should work on OMAP4460/4470 since those chips don't
> have a CTI dependency for the PMU?
>
You are right. OMAP44_60/70 should work.

Thanks for clarification Paul.

Regards
Santosh
