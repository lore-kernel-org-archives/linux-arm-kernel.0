From: james.morse@arm.com (James Morse)
Date: Wed, 01 Nov 2017 14:57:35 +0000
Subject: [RFC/RFT PATCH 3/6] ACPI / APEI: Replace ioremap_page_range()
 with fixmap
In-Reply-To: <3b796e66-1618-0a6e-e57e-99323514b84d@huawei.com>
References: <20171031153832.17746-1-james.morse@arm.com>
 <20171031153832.17746-4-james.morse@arm.com>
 <3b796e66-1618-0a6e-e57e-99323514b84d@huawei.com>
Message-ID: <59F9E0DF.20006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdonjiu,

On 01/11/17 04:13, gengdongjiu wrote:
> On 2017/10/31 23:38, James Morse wrote:
>> CC'd people I've seen posting CPER log fragments, could you give this a
>> test on your platforms?

> Thanks for the fixing, not found obviously issue.

Can I take that as a 'Tested-by:'?

These tags also let us record who has a system that can test changes to this driver.


Thanks,

James
