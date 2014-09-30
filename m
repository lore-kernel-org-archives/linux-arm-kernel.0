From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 30 Sep 2014 15:10:07 -0700
Subject: [PATCH v3 0/6] Migrate PXA27x platforms to clock framework
In-Reply-To: <87iok4bwcj.fsf@free.fr>
References: <1406753464-15000-1-git-send-email-robert.jarzmik@free.fr>
 <1465795.XsPpj3dZHX@wuerfel> <87d2bq43pc.fsf@free.fr>
 <201408241408.19861.arnd@arndb.de>
 <20140903184956.11368.47800@quantum> <874mw2xoau.fsf@free.fr>
 <20140930195257.19023.57219@quantum> <87iok4bwcj.fsf@free.fr>
Message-ID: <CAPtuhTjai9=jXCu_b6PPPxzDBuv07qNuVoW_iiP_o8f=LPyiMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 3:02 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Mike Turquette <mturquette@linaro.org> writes:
>
>> Quoting Robert Jarzmik (2014-09-20 09:13:45)
>> Hi Robert,
>>
>> Tomeu's stuff won't go into 3.18. I should have circled back to these
>> patches when that become apparent, but it got lost in the paperwork.
>>
>> I can take these patches without you rebasing onto his work. Since we
>> have -rc7 I think there is time and these patches shouldn't wait for
>> another merge window. I've applied them to clk-next from a stable branch
>> with these six patches based on -rc1.
>
> Thanks Mike, that's perfect. These patches are my corner stone to unblock the
> pxa device-tree port (at least on pxa27x).
>
> There will be at least 1 corrective patch for init ordering (clocks must be
> initialized before the clocksource). But I believe it will go during the
> 3.18-rcs. I'll post the patch tomorrow for it to gather enough acks.
>
> And I have also a patch for Tomeu's change. It's really small, so I'll post it
> too, but not for submission, just to have it reviewed when the API change will
> be ready.

OK, that sounds great. Please note that the 01.org builder found a
problem with the Kconfig bits. Can you look into it?

Thanks,
Mike

>
> Thanks.
>
> --
> Robert
