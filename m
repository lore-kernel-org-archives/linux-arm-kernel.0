From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 18 Nov 2014 21:15:43 +0100
Subject: [PATCH v5 03/18] ACPI / table: Count matched and successfully
 parsed entries without specifying max entries
In-Reply-To: <546B4EDD.9050804@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-4-git-send-email-hanjun.guo@linaro.org>
 <546B4EDD.9050804@linaro.org>
Message-ID: <7743567.TJcygJtKD3@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 18, 2014 09:51:25 PM Hanjun Guo wrote:
> Hi Rafael,
> 
> On 2014?10?17? 21:36, Hanjun Guo wrote:
> > From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >
> > It is very useful to traverse all available table entries without max
> > number of expected entries type. Current acpi_parse_entries()
> > implementation gives that feature but it does not count those entries,
> > it returns 0 instead, so fix it to count matched and successfully
> > entries and return it.
> >
> > NOTE: This change has no impact to x86 and ia64 archs since existing code
> > checks for error occurrence only (acpi_parse_entries(...,0) < 0).
> >
> > Acked-by: Grant Likely <grant.likely@linaro.org>
> > Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Patch 2 and patch 3 are only for ACPI cores, and have no harm to x86
> and IA64, could you merge first in 3.19?

I can do that if that helps.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
