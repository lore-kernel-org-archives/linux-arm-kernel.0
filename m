From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 21 Feb 2013 20:42:53 +0530
Subject: too many timer retries happen when do local timer swtich with
 broadcast timer
In-Reply-To: <alpine.LFD.2.02.1302211436300.22263@ionos>
References: <CAB4PhKevqf0e4nzYraE9ZTAFbPCFfNpguAnPoVpJh-FFe2TAZA@mail.gmail.com>
 <alpine.LFD.2.02.1302201400400.22263@ionos>
 <CAB4PhKfxPcyQfpM2Ra1OxsyYhS5fnkjtPy=uYgxFHim1rOdoug@mail.gmail.com>
 <alpine.LFD.2.02.1302211015270.22263@ionos>
 <CAB4PhKf+Z-TK4KGDZm1kYOWibg=e2Ehnhjxt_oTbFq9eqouAjA@mail.gmail.com>
 <alpine.LFD.2.02.1302211436300.22263@ionos>
Message-ID: <51263975.20906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Thursday 21 February 2013 07:18 PM, Thomas Gleixner wrote:
> Jason,
>
> On Thu, 21 Feb 2013, Jason Liu wrote:
>> 2013/2/21 Thomas Gleixner <tglx@linutronix.de>:
>>> Now your explanation makes sense.
>>>
>>> I have no fast solution for this, but I think that I have an idea how
>>> to fix it. Stay tuned.
>>
>> Thanks Thomas, wait for your fix. :)
>
> find below a completely untested patch, which should address that issue.
>
After looking at the thread, I tried to see the issue on OMAP and could
see the same issue as Jason.

Your patch fixes the retries on both CPUs on my dual core machine. So
you use my tested by if you need one.
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks for the patch.
And thanks to Jason for spotting the issue.

Regards,
Santosh
