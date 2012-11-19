From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Nov 2012 07:52:36 -0600
Subject: [PATCH v2 2/5] ARM: gic: remove direct use of gic_raise_softirq
In-Reply-To: <20121119130718.025b7a2c@skate>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
 <1351695517-5636-3-git-send-email-robherring2@gmail.com>
 <20121102124433.GA28213@bnru03> <20121119115021.GA19788@bnru10>
 <20121119130718.025b7a2c@skate>
Message-ID: <50AA39A4.1060006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2012 06:07 AM, Thomas Petazzoni wrote:
> 
> On Mon, 19 Nov 2012 17:20:22 +0530, Srinidhi Kasagar wrote:
>>>>         for (i = 0; i < ncores; i++)
>>>>                 set_cpu_possible(i, true);
>>>> -
>>>> -       set_smp_cross_call(gic_raise_softirq);
>>>
>>> The ux500 changes looks ok too..
>>>
>>> However would you mind re-spinning your series on top of the below patch?
>>
>> ping??
> 
> I have merged Linus Walleij patches into my irqchip branch with more
> changes around the irqchip infrastructure. That said, it will not be
> part of the 3.8 release cycle, so we will definitely take care of
> re-spinning against the latest ux500 changes.

I still hope to get some of the clean-up in for 3.8 if not the move
itself. So I can include your patch. Is it in an arm-soc branch already?

Rob
