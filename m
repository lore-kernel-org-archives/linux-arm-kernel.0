From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 6 May 2011 14:38:48 +0300
Subject: [PATCH V2 04/16] mmc: omap_hsmmc: reduce a bit the error handlers
	in probe()
In-Reply-To: <BANLkTi=wiC13bh5vO6rouzCwZCO+-cxbuQ@mail.gmail.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
	<1304673255-31634-5-git-send-email-adrian.hunter@nokia.com>
	<BANLkTi=wiC13bh5vO6rouzCwZCO+-cxbuQ@mail.gmail.com>
Message-ID: <BANLkTimBafJFE7+WBobBV7pc+X_=FBsTMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 6, 2011 at 2:34 PM, Varadarajan, Charulatha <charu@ti.com> wrote:
> On Fri, May 6, 2011 at 14:44, Adrian Hunter <adrian.hunter@nokia.com> wrote:
>> From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>>
>
> Add patch description here.
You mean something like following:
"The code contains similarities in the error path of probe function.
Let's combine them at one place."
?

>
>> Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
>> ---
>> ?drivers/mmc/host/omap_hsmmc.c | ? 17 ++++++-----------
>> ?1 files changed, 6 insertions(+), 11 deletions(-)
>>
>
> <<snip>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>



-- 
With Best Regards,
Andy Shevchenko
