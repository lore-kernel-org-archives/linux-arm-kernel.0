From: shaik.samsung@gmail.com (Shaik Ameer Basha)
Date: Tue, 1 Apr 2014 10:12:03 +0530
Subject: [PATCH v2 3/7] clk: exynos5420: Rename clock IDs
In-Reply-To: <20140327194959.GY3998@book.gsilab.sittig.org>
References: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
 <1395918470-16374-4-git-send-email-shaik.ameer@samsung.com>
 <20140327194959.GY3998@book.gsilab.sittig.org>
Message-ID: <CAOD6ATqRGgz9MxWYBs6Bo_xh2+N6trVByywXE_dxv9N=tpkTDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 1:19 AM, Gerhard Sittig <gsi@denx.de> wrote:
> On Thu, 2014-03-27 at 16:37 +0530, Shaik Ameer Basha wrote:
>>
>> From: Rahul Sharma <rahul.sharma@samsung.com>
>>
>> This patch renames the clock IDs used for the DT bindings as
>> per Exynos5420 datasheet.
>>
>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos5420.c   |  162 +++++++++++++++++---------------
>>  include/dt-bindings/clock/exynos5420.h |  138 +++++++++++++--------------
>>  2 files changed, 154 insertions(+), 146 deletions(-)
>
> does this break bisection when you rename symbolic identifiers in
> their declaration yet don't update references at the users?

Hi Gerhard,

Thanks for the review.
You are right. Actually I check for bisect build when I rebased to
linux-next and samsung-clk (of tomasz figa) branches.

I didn't check for bisect build after rebased to following patch.
ARM: dts: use macros in clock bindings for exynos5420

>
>
> virtually yours
> Gerhard Sittig
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
