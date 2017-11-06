From: james.morse@arm.com (James Morse)
Date: Mon, 06 Nov 2017 18:41:58 +0000
Subject: [RFC/RFT PATCH 3/6] ACPI / APEI: Replace ioremap_page_range()
 with fixmap
In-Reply-To: <459a2731-b7eb-5836-93fd-57b7feaa5e40@huawei.com>
References: <20171031153832.17746-1-james.morse@arm.com>
 <20171031153832.17746-4-james.morse@arm.com>
 <3b796e66-1618-0a6e-e57e-99323514b84d@huawei.com> <59F9E0DF.20006@arm.com>
 <459a2731-b7eb-5836-93fd-57b7feaa5e40@huawei.com>
Message-ID: <5A00ACF6.2010200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu

On 02/11/17 12:01, gengdongjiu wrote:
> James Morse wrote:
>> Can I take that as a 'Tested-by:'?
>>
>> These tags also let us record who has a system that can test changes to this driver.
> 
> sure.
> Thanks for the fixing.
> Qiang Zheng who is my colleague have tested it.
> 
> CC  Qiang.
> 
> Tested-by:  Qiang Zheng <zhengqiang10@huawei.com>

I can't do anything with this unless Qiang posts it. (I'll add to the CC list in
the next version)

>From Documentation/process/5.Posting.rst:
> Be careful in the addition of tags to your patches: only Cc: is appropriate
> for addition without the explicit permission of the person named.



Thanks,

James
