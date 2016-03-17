From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 17 Mar 2016 09:40:37 -0500
Subject: [PATCH v2 all 04/14] arc: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E906A5@us01wembx1.internal.synopsys.com>
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
 <1458113743-15131-5-git-send-email-wangkefeng.wang@huawei.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E903CE@us01wembx1.internal.synopsys.com>
 <CAL_JsqJm3AH9Exb7JifA8A4ktFcpLV=76+aC+2AsTYz-W-AZPg@mail.gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E906A5@us01wembx1.internal.synopsys.com>
Message-ID: <CAL_JsqJ0Myvc6st7iFLFE9iVVhT0gCi5V6qgU33sztw2zfe94A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 9:19 AM, Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
> On Thursday 17 March 2016 06:58 PM, Rob Herring wrote:
>>> Perhaps too late - but can't of_platform_default_populate just be a static inline
>>> > calling of_platform_populate in the header rather than exporting yet another symbol !
>> The idea is to not export the variable of_default_bus_match_table and
>> export a function instead.
>>
>> Rob
>
> Yep I realized this after reading the cover letter of patch which I didn't get !
>
> BTW since I got your attention, could u please take a look at
> http://lists.infradead.org/pipermail/linux-snps-arc/2016-March/000653.html
> and
> http://lists.infradead.org/pipermail/linux-snps-arc/2016-March/000656.html

If it is in DT patchworks, I'll get to it soon. I'm about 2 weeks
behind between conference and vacation.

Rob
